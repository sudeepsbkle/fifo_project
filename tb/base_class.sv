class random_test;
  virtual fifo_if.DRV  vdrv;
  virtual fifo_if.MON  vmon;
  string test_case_name = "random_test";

  function new(virtual fifo_if vif);
    vdrv = vif.DRV;
    vmon = vif.MON;
  endfunction

  virtual task configure();
    tb_logger::info("TEST", $sformatf("Configuring %s", test_case_name));
  endtask

  task run();
    tb_logger::info("TEST", $sformatf("Starting %s", test_case_name));
    configure();
    // env.pre_test();  // Remove env calls
    // env.start_agents(); // Remove env calls  
    execute_test();
    repeat(10) @(posedge vdrv.clk);
    tb_logger::info("TEST", $sformatf("%s completed", test_case_name));
  endtask

  virtual task execute_test();
  endtask
endclass
