local function map(mode, from, to, opts)
    vim.api.nvim_set_keymap(mode, from, to, opts or { silent = true })
end
local function nmap(from, to, opts) map("n", from, to, opts) end

require("jdtls").start_or_attach(
    {
        on_attach = function() nmap("<leader>f", ":lua vim.lsp.buf.formatting()<CR>") end,

        cmd = {

            "java",

            "-Declipse.application=org.eclipse.jdt.ls.core.id1",
            "-Dosgi.bundles.defaultStartLevel=4",
            "-Declipse.product=org.eclipse.jdt.ls.core.product",
            "-Dlog.protocol=true",
            "-Dlog.level=ALL",
            "-Xms1g",
            "--add-modules=ALL-SYSTEM",
            "--add-opens",
            "java.base/java.util=ALL-UNNAMED",
            "--add-opens",
            "java.base/java.lang=ALL-UNNAMED",

            "-jar",
            "/usr/share/java/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar",

            "-configuration",
            "/usr/share/java/jdtls/config_linux",

            "-data",
            "/home/toby/cs/java",
        },

        root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" }),

        -- Here you can configure eclipse.jdt.ls specific settings
        -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
        -- for a list of options
        settings = { java = {} },

        init_options = { bundles = {} },
    }
)
