class tc3_read_when_empty extends random_test;

  function new(virtual fifo_if vif);
    super.new(vif);
    test_case_name = "TC3: Read when empty";
  endfunction


  virtual task execute_test();

    tb_logger::info("TC3", "Reading from empty FIFO");

    repeat(`BUF_SIZE) begin
      @(posedge vdrv.clk);
      vdrv.cb.wr <= 0;
      vdrv.cb.rd <= 1;
    end

  endtask

endclass