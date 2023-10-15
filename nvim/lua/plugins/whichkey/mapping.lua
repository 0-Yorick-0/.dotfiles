return {
    -- Treesitter
    c = {
        name = "+Code",
        x = {
            name = "Swap Next",
            f = "Function",
            p = "Parameter",
            c = "Class",
        },
        X = {
            name = "Swap Previous",
            f = "Function",
            p = "Parameter",
            c = "Class",
        },
    },
    -- PHP
    p = {
        name = "PhpActor",
        gd = { "<cmd>PhpactorGotoDefinition<CR>", "[G]oto[D]efinition" },
        gdv = { "<cmd>PhpactorGotoDefinition vsplit<CR>", "[G]oto[D]efinition [v]split" },
        i = { "<cmd>PhpactorImportClass<CR>", "[I]mportClass" },
        cf = { "<cmd>PhpactorCopyFile<CR>", "[C]opy[F]ile" },
        cc = { "<cmd>PhpactorCopyClassName<CR>", "[C]opy[C]lassName" },
        -- find usages in quifix list
        fr = { "<cmd>PhpactorFindReferences<CR>", "[F]ind[R]eferences" },
        -- jump to parent class
        nv = { "<cmd>PhpactorNavigate<CR>", "[N]a[v]igate" },
        im = { "<cmd>PhpactorGotoImplementations<CR>", "Go to [Im]plementations" },
        -- open context menu
        cm = { "<cmd>PhpactorContextMenu<CR>", "Open [C]ontext[M]enu" },
        tr = { "<cmd>PhpactorTransform<CR>", "Open [Tr]ansform" },
    },
    -- GO
    g = {
        name = "Golang",
        i = { "<cmd>GoImports<CR>", "[I]mport" },
        g = { "<cmd>GoGet<CR>", "[G]et" },
        r = { "<cmd>GoRun<CR>", "[R]un" },
        s = { "<cmd>GoStop<CR>", "[S]top" },
        rn = { "<cmd>GoRename<CR>", "[R]ename" },
        t = { "<cmd>GoTest<CR>", "[T]est" },
        tf = { "<cmd>GoTestFunc<CR>", "[T]est[F]unction" },
        at = { "<cmd>GoAddTest<CR>", "[A]dd[T]est" },
    },
    -- Database
    D = {
        name = "Database",
        u = { "<Cmd>DBUIToggle<Cr>", "Toggle UI" },
        f = { "<Cmd>DBUIFindBuffer<Cr>", "Find buffer" },
        r = { "<Cmd>DBUIRenameBuffer<Cr>", "Rename buffer" },
        q = { "<Cmd>DBUILastQueryInfo<Cr>", "Last query info" },
    },
    -- Debugging
    d = {
        name = "Debugging",
        U = { "<cmd>lua require'dapui'.toggle()<cr>", "Toggle UI" },
        t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
        C = { "<cmd>lua require'dap'.set_breakpoint(vim.fn.input '[Condition] > ')<cr>", "Conditional Breakpoint" },
        s = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
        p = { "<cmd>lua require'dap'.pause.toggle()<cr>", "Pause" },
        d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
        x = { "<cmd>lua require'dap'.terminate()<cr>", "Terminate" },
        R = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run to Cursor" },
        b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
        c = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
        i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
        o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
        O = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
        l = { "<cmd>lua require'dap'.set_breakpoint(nil, vim.fn.input('Exception: '))<cr>", "Exception Breakpoint" },
        e = { "<cmd>lua require'dap'.repl.run_last()<cr>", "Run Last" },
        E = { "<cmd>lua require'dapui'.eval(vim.fn.input '[Expression] > ')<cr>", "Evaluate Input" },
        h = { "<cmd>lua require'dap.ui.widgets'.hover()<cr>", "Hover Variables" },
        S = { "<cmd>lua require'dap.ui.widgets'.scopes()<cr>", "Scopes" },
        r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
        g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
    },
}
