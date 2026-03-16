class tc4_write_until_full extends random_test;

  function new(virtual fifo_if vif);
    super.new(vif);
    test_case_name = "TC4: Write until full";
  endfunction

  virtual task execute_test();

    tb_logger::info("TC4", "Writing until FIFO becomes FULL");

    while(!vmon.full) begin
      @(posedge vdrv.clk);
      vdrv.cb.wr     <= 1;
      vdrv.cb.rd     <= 0;
      vdrv.cb.datain <= $urandom;
    end

    tb_logger::info("TC4", "FIFO FULL detected (full = 1)");

  endtask

endclass