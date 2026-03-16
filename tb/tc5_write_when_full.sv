class tc5_write_when_full extends random_test;

  function new(virtual fifo_if vif);
    super.new(vif);
    test_case_name = "TC5: Write when full";
  endfunction


  virtual task execute_test();

    tb_logger::info("TC5", "Filling FIFO until FULL");

    // Phase 1: Fill FIFO
    while (!vmon.full) begin
      @(posedge vdrv.clk);
      drive_write();
    end

    tb_logger::info("TC5", "FIFO FULL detected, attempting 5 overflow writes");

    // Phase 2: Try 5 extra writes (overflow attempt)
    repeat (5) begin
      @(posedge vdrv.clk);
      drive_write();
    end

    // Stop driving write
    @(posedge vdrv.clk);
    vdrv.cb.wr <= 0;

  endtask


  // Reusable write task
  task drive_write();
    vdrv.cb.wr     <= 1;
    vdrv.cb.rd     <= 0;
    vdrv.cb.datain <= $urandom;
  endtask

endclass