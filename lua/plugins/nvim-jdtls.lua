return {
    'mfussenegger/nvim-jdtls',
    ft = 'java',
    config = function()
        local jdtls = require('jdtls')

        -- Find root of project
        local root_markers =
            { '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' }
        local root_dir = require('jdtls.setup').find_root(root_markers)

        -- Eclipse jdtls location using nvim data directory
        local jdtls_path = vim.fn.stdpath('data') .. '/mason/packages/jdtls'
        local lombok_path = jdtls_path .. '/lombok.jar'

        -- OS-specific configuration directory
        local config_dir
        if vim.fn.has('mac') == 1 then
            config_dir = jdtls_path .. '/config_mac'
        elseif vim.fn.has('unix') == 1 then
            config_dir = jdtls_path .. '/config_linux'
        else
            config_dir = jdtls_path .. '/config_win'
        end

        -- Use nvim data directory for workspace
        local workspace_dir = vim.fn.stdpath('data')
            .. '/jdtls-workspace/'
            .. vim.fn.fnamemodify(root_dir or vim.fn.getcwd(), ':p:h:t')

        local config = {
            cmd = {
                'java',
                '-Declipse.application=org.eclipse.jdt.ls.core.id1',
                '-Dosgi.bundles.defaultStartLevel=4',
                '-Declipse.product=org.eclipse.jdt.ls.core.product',
                '-javaagent:' .. lombok_path,
                '--add-modules=ALL-SYSTEM',
                '--add-opens',
                'java.base/java.util=ALL-UNNAMED',
                '--add-opens',
                'java.base/java.lang=ALL-UNNAMED',
                '-jar',
                vim.fn.glob(
                    jdtls_path .. '/plugins/org.eclipse.equinox.launcher_*.jar'
                ),
                '-configuration',
                config_dir,
                '-data',
                workspace_dir,
            },
            root_dir = root_dir,
            capabilities = require('blink.cmp').get_lsp_capabilities(),
            settings = {
                java = {
                    eclipse = {
                        downloadSources = true,
                    },
                    maven = {
                        downloadSources = true,
                    },
                    configuration = {
                        updateBuildConfiguration = 'interactive',
                    },
                    compile = {
                        nullAnalysis = {
                            mode = 'automatic',
                        },
                    },
                },
            },
        }

        jdtls.start_or_attach(config)
    end,
}
