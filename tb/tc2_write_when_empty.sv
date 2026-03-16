class tc2_write_when_empty extends random_test;

  function new(virtual fifo_if vif);
    super.new(vif);
    test_case_name = "TC2: Write when empty";
  endfunction


  virtual task execute_test();

    tb_logger::info("TC2", "Writing when FIFO is empty");

    repeat(`BUF_SIZE) begin
      @(posedge vdrv.clk);
      vdrv.cb.wr     <= 1;
      vdrv.cb.rd     <= 0;
      vdrv.cb.datain <= $urandom;
    end

  endtask

endclass