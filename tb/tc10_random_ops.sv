class tc10_random_ops extends random_test;

  function new(virtual fifo_if vif);
    super.new(vif);
    test_case_name = "TC10: Random operations";
  endfunction


  virtual task execute_test();

    tb_logger::info("TC10", "Starting Random FIFO Operations");

    repeat (100) begin
      @(posedge vdrv.clk);

      vdrv.cb.wr     <= $urandom_range(0,1);
      vdrv.cb.rd     <= $urandom_range(0,1);
      vdrv.cb.datain <= $urandom;

    end

    tb_logger::info("TC10", "Random operations completed");

    repeat (10) @(posedge vdrv.clk);

  endtask

endclass
