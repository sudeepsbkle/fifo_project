class environment;

  generator  gen;
  driver     drv;
  monitor    mon;
  scoreboard sb;

  mailbox gen2drv;
  mailbox drv2sb;
  mailbox mon2sb;

  virtual fifo_if.DRV vdrv;
  virtual fifo_if.MON vmon;

  function new(virtual fifo_if.DRV vdrv,
               virtual fifo_if.MON vmon);

    this.vdrv = vdrv;
    this.vmon = vmon;

    tb_logger::info("ENV", "Building verification environment");

    gen2drv = new();
    drv2sb  = new();
    mon2sb  = new();

    tb_logger::info("ENV", "Mailboxes created");

    gen = new(gen2drv);
    drv = new(vdrv, gen2drv, drv2sb);
    mon = new(vmon, mon2sb);
    sb  = new(drv2sb, mon2sb);

    tb_logger::info("ENV", "All components constructed");

  endfunction


  task pre_test();

    tb_logger::info("ENV", "Starting Reset Sequence");

    drv.reset();

    tb_logger::info("ENV", "Reset completed");

  endtask


  task start_agents();

    tb_logger::info("ENV", "Starting driver, monitor and scoreboard");

    fork
      drv.drive();
      mon.run();
      sb.run();
    join_none

  endtask

endclass

