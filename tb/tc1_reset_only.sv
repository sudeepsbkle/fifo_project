class tc1_reset_only extends random_test;

  function new(virtual fifo_if vif);  
    super.new(vif);
    test_case_name = "TC1: Reset only";
  endfunction


  virtual task execute_test();

    tb_logger::info("TC1", "Running Reset Only Test");

    repeat(10) @(posedge vdrv.clk);

  endtask

endclass

