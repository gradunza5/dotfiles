return {
    "mfussenegger/nvim-dap",
    dependencies = {
        { "rcarriga/nvim-dap-ui" },
        { "theHamsta/nvim-dap-virtual-text" },
        { "nvim-telescope/telescope-dap.nvim" },
        { "jbyuki/one-small-step-for-vimkind" },
        { "nvim-neotest/nvim-nio" },
    },
    keys = {
        { "<leader>dR",  function() require("dap").run_to_cursor() end,                               desc = "[D]ebug: [R]un to Cursor", },
        { "<leader>di",  function() require("dapui").eval(vim.fn.input "[Expression] > ") end,        desc = "[D]ebug: Evaluate [I]nput", },
        { "<leader>dC",  function() require("dap").set_breakpoint(vim.fn.input "[Condition] > ") end, desc = "[D]ebug: [C]onditional Breakpoint", },
        { "<leader>dU",  function() require("dapui").toggle() end,                                    desc = "[D]ebug: Toggle [U]I", },
        { "<leader>dsb", function() require("dap").step_back() end,                                   desc = "[D]ebug: [S]tep [B]ack", },
        { "<leader>dc",  function() require("dap").continue() end,                                    desc = "[D]ebug: [C]ontinue", },
        { "<leader>dd",  function() require("dap").disconnect() end,                                  desc = "[D]ebug: [D]isconnect", },
        { "<leader>dE",  function() require("dapui").eval() end,                                      mode = { "n", "v" },                        desc = "[D]ebug: [E]valuate", },
        { "<leader>dg",  function() require("dap").session() end,                                     desc = "[D]ebug: [G]et Session", },
        { "<leader>dh",  function() require("dap.ui.widgets").hover() end,                            desc = "[D]ebug: [H]over Variables", },
        { "<leader>dS",  function() require("dap.ui.widgets").scopes() end,                           desc = "[D]ebug: [S]copes", },
        { "<leader>di",  function() require("dap").step_into() end,                                   desc = "[D]ebug: Step [I]nto", },
        { "<leader>do",  function() require("dap").step_over() end,                                   desc = "[D]ebug: Step [O]ver", },
        { "<leader>dp",  function() require("dap").pause.toggle() end,                                desc = "[D]ebug: [P]ause", },
        { "<leader>dQ",  function() require("dap").close() end,                                       desc = "[D]ebug: [Q]uit", },
        { "<leader>dr",  function() require("dap").repl.toggle() end,                                 desc = "[D]ebug: Toggle [R]EPL", },
        { "<leader>ds",  function() require("dap").continue() end,                                    desc = "[D]ebug: [S]tart", },
        { "<leader>db",  function() require("dap").toggle_breakpoint() end,                           desc = "[D]ebug: Toggle [B]reakpoint", },
        { "<leader>dx",  function() require("dap").terminate() end,                                   desc = "[D]ebug: [X]-Terminate", },
        { "<leader>du",  function() require("dap").step_out() end,                                    desc = "[D]ebug: Step Out", },
        -- Custom
        { "<leader>dk",  function() require("dap").up() end,                                          desc = "[D]ebug: Go Up 1 Stack Frame", },
        { "<leader>dj",  function() require("dap").down() end,                                        desc = "[D]ebug: Go Down 1 Stack Frame", },
        { "<F1>",        function() require("dap.ui.widgets").hover() end,                            desc = "[D]ebug: Hover Variables", },
        { "<F5>",        function() require("dap").continue() end,                                    desc = "[D]ebug: Continue", },
        { "<F9>",        function() require("dap").toggle_breakpoint() end,                           desc = "[D]ebug: Toggle Breakpoint", },
        { "<F10>",       function() require("dap").step_over() end,                                   desc = "[D]ebug: Step Over", },
        { "<F11>",       function() require("dap").step_into() end,                                   desc = "[D]ebug: Step In", },
        { "<S-F11>",     function() require("dap").step_out() end,                                    desc = "[D]ebug: Step Out", },
        { "<M-d>",       function() require("dap.ui.widgets").hover() end,                            desc = "[D]ebug: Hover Variables", },
    },
    opts = {
        setup = {
            osv = function(_, _) end,
        },
    },
    config = function(plugin, opts)
        require("nvim-dap-virtual-text").setup({ commented = true, })

        local dap = require("dap")
        local dapui = require("dapui")

        dapui.setup({})
        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
        end

        vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticSignError", linehl = "", numhl = "" })
        vim.fn.sign_define("DapBreakpointCondition", {
            text = "🯄",
            texthl = "DiagnosticSignError",
            linehl = "",
            numhl =
            ""
        })
        vim.fn.sign_define("DapBreakpointRejected",
            { text = "ⓧ", texthl = "DiagnosticSignWarn", linehl = "", numhl = "" })
        vim.fn.sign_define("DapLogPoint", { text = "✎", texthl = "DiagnosticSignInfo", linehl = "", numhl = "" })
        vim.fn.sign_define("DapStopped",
            { text = "→", texthl = "DiagnosticSignWarn", linehl = "DiagnosticSignError", numhl = "DiagnosticSignError" })

        -- Keep DAP out of BufferLine
        vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
            pattern = {
                "*DAP *",
            },
            callback = function()
                vim.cmd("setl nobuflisted")
            end,
        })

        -- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#python
        -- dap.configurations.rust = dap.configurations.cpp

        -- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#python
        dap.adapters.python = function(cb, config)
            if config.request == "attach" then
                ---@diagnostic disable-next-line: undefined-field
                local port = (config.connect or config).port
                ---@diagnostic disable-next-line: undefined-field
                local host = (config.connect or config).host or "127.0.0.1"
                cb({
                    type = "server",
                    port = assert(port, "`connect.port` is required for a python `attach` configuration"),
                    host = host,
                    options = {
                        source_filetype = "python",
                    },
                })
            else
                cb({
                    type = "executable",
                    -- command =  vim.fn.expand("$HOME/.local/opt/debugpy/bin/python"),
                    command = "python",
                    args = { "-m", "debugpy.adapter" },
                    options = {
                        source_filetype = "python",
                    },
                })
            end
        end
        dap.configurations.python = {
            {
                -- The first three options are required by nvim-dap
                type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
                request = "launch",
                name = "Launch file",

                -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-setting
                program = "${file}", -- This configuration will launch the current file if used.
                pythonPath = function()
                    -- "debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself."
                    -- NOTE: This does not seem to work with the vscode launch.json extension
                    local cwd = vim.fn.getcwd()
                    if os.getenv("VIRTUAL_ENV") then
                        return os.getenv("VIRTUAL_ENV") .. "/bin/python"
                    elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
                        return cwd .. "/.venv/bin/python"
                    elseif vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
                        return cwd .. "/venv/bin/python"
                    else
                        return "python"
                    end
                end,
            }
        }

        -- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#dotnet
        dap.adapters.coreclr = {
            type = "executable",
            command = "netcoredbg",
            args = { "--interpreter=vscode" }
        }
        dap.configurations.cs = {
            {
                type = "coreclr",
                name = "launch - netcoredbg",
                request = "launch",
                program = function()
                    local debugdir = vim.fn.getcwd() .. '/bin/Debug/'
                    local basepath = string.match(vim.fn.getcwd(), "[/\\]([^/\\]*)$")
                    local dll = vim.fn.globpath(debugdir, 'net*/' .. basepath .. '.dll')
                    return vim.fn.input('Path to dll', dll, 'file')
                end,
            },
        }

        require("dap.ext.vscode").load_launchjs()

        -- set up debugger
        for k, _ in pairs(opts.setup) do
            opts.setup[k](plugin, opts)
        end

        -- Keep DAP out of BufferLine
        vim.api.nvim_create_autocmd({ "WinNew", "WinLeave" },
            {
                pattern = {
                    "*DAP*",
                    "*dap*",
                },
                callback = function(args)
                    vim.api.nvim_buf_set_option(args.buf, "buflisted", false)
                end,
            }
        )
    end,
}
