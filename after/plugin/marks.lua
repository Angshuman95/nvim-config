local staus_ok, marks = pcall(require, 'marks')
if not staus_ok then
    return
end

marks.setup()
