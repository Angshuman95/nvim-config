return {
    'mfussenegger/nvim-jdtls',
    config = function()
        local jdtls = require('jdtls')

        local function setup_jdtls()
            -- Find root of project - prioritize parent pom.xml
            local root_markers = { '.git', 'mvnw', 'gradlew' }
            local root_dir = require('jdtls.setup').find_root(root_markers)

            -- If no root found with git markers, look for parent pom.xml
            if not root_dir then
                local current_dir = vim.fn.expand('%:p:h')
                local parent_pom_markers = { 'pom.xml' }
                root_dir = require('jdtls.setup').find_root(parent_pom_markers)

                -- Check if this is a parent pom (multi-module)
                local pom_path = root_dir and (root_dir .. '/pom.xml') or nil
                if pom_path and vim.fn.filereadable(pom_path) == 1 then
                    local pom_content = vim.fn.readfile(pom_path)
                    local is_parent = false
                    for _, line in ipairs(pom_content) do
                        if line:match('<modules>') then
                            is_parent = true
                            break
                        end
                    end

                    -- If not a parent pom, look for parent directory with parent pom
                    if not is_parent then
                        local parent_dir = vim.fn.fnamemodify(root_dir, ':h')
                        local parent_pom = parent_dir .. '/pom.xml'
                        if vim.fn.filereadable(parent_pom) == 1 then
                            local parent_content = vim.fn.readfile(parent_pom)
                            for _, line in ipairs(parent_content) do
                                if line:match('<modules>') then
                                    root_dir = parent_dir
                                    break
                                end
                            end
                        end
                    end
                end
            end

            -- Fallback to current working directory
            root_dir = root_dir or vim.fn.getcwd()

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

            -- Use project name for workspace to ensure single workspace per project
            local project_name = vim.fn.fnamemodify(root_dir, ':t')
            local workspace_dir = vim.fn.stdpath('data')
                .. '/jdtls-workspace/'
                .. project_name

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
                        jdtls_path
                            .. '/plugins/org.eclipse.equinox.launcher_*.jar'
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
                        -- Add settings for multi-module projects
                        import = {
                            maven = {
                                enabled = true,
                            },
                            gradle = {
                                enabled = false,
                            },
                        },
                    },
                },
                -- Add initialization options for better multi-module support
                init_options = {
                    bundles = {},
                    extendedClientCapabilities = {
                        progressReportProvider = false,
                        classFileContentsSupport = true,
                        generateToStringPromptSupport = true,
                        hashCodeEqualsPromptSupport = true,
                        advancedExtractRefactoringSupport = true,
                        advancedOrganizeImportsSupport = true,
                        generateConstructorsPromptSupport = true,
                        generateDelegateMethodsPromptSupport = true,
                        moveRefactoringSupport = true,
                    },
                },
            }

            jdtls.start_or_attach(config)
        end

        -- Create an autocommand group for JDTLS
        local jdtls_augroup =
            vim.api.nvim_create_augroup('JDTLS', { clear = true })

        -- Only start JDTLS for real Java files with proper conditions
        vim.api.nvim_create_autocmd('FileType', {
            group = jdtls_augroup,
            pattern = 'java',
            callback = function(args)
                local bufnr = args.buf
                local bufname = vim.api.nvim_buf_get_name(bufnr)

                -- Only proceed if this is a real file with .java extension
                if
                    bufname ~= ''
                    and bufname:match('%.java$')
                    and vim.fn.filereadable(bufname) == 1
                then
                    -- Additional check: ensure buffer is not temporary
                    local buftype = vim.api.nvim_get_option_value(
                        'buftype',
                        { buf = bufnr }
                    )
                    if buftype == '' then
                        setup_jdtls()
                    end
                end
            end,
        })
    end,
}
