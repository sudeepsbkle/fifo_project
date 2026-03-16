class tc7_simultaneous_wr_rd extends random_test;

  function new(virtual fifo_if vif);
    super.new(vif);
    test_case_name = "TC7: Simultaneous write/read";
  endfunction


  virtual task execute_test();

    tb_logger::info("TC7", "Starting Simultaneous Write/Read Test");

    // Phase 1: Pre-fill FIFO with half buffer
    repeat (`BUF_SIZE/2) begin
      @(posedge vdrv.clk);
      vdrv.cb.wr     <= 1;
      vdrv.cb.rd     <= 0;
      vdrv.cb.datain <= $urandom;
    end

    tb_logger::info("TC7", "Starting simultaneous write and read");

    // Phase 2: Simultaneous write and read
    repeat (16) begin
      @(posedge vdrv.clk);
      vdrv.cb.wr     <= 1;
      vdrv.cb.rd     <= 1;
      vdrv.cb.datain <= $urandom;
    end

    tb_logger::info("TC7", "Simultaneous operation completed");

    // Let pipeline settle
    repeat (5) @(posedge vdrv.clk);

    // Stop driving signals
    @(posedge vdrv.clk);
    vdrv.cb.wr <= 0;
    vdrv.cb.rd <= 0;

  endtask

endclass
