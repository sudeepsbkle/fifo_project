class monitor;

  virtual fifo_if.MON vif;
  mailbox mon2scb;

  function new(virtual fifo_if.MON vif, mailbox mon2scb);
    this.vif = vif;
    this.mon2scb = mon2scb;
  endfunction

  task run();

    transaction tr;

    tb_logger::info("MONITOR", "Monitor started");

    forever begin
      @(posedge vif.clk);

      tr = new();

      tr.wr      = vif.wr;
      tr.rd      = vif.rd;
      tr.datain  = vif.datain;
      tr.dataout = vif.dataout;
      tr.full    = vif.full;
      tr.empty   = vif.empty;

      mon2scb.put(tr);

      $display("%0t MON wr=%0d rd=%0d full=%0d empty=%0d din=%0h dout=%0h",
               $time, vif.wr, vif.rd, vif.full, vif.empty, vif.datain, vif.dataout);

    end

  endtask

endclass