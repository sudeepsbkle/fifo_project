class fifo_test_suite;

  environment          env;
  virtual fifo_if.DRV  vdrv;
  virtual fifo_if.MON  vmon;

  function new(environment env,
               virtual fifo_if.DRV vdrv,
               virtual fifo_if.MON vmon);

    this.env  = env;
    this.vdrv = vdrv;
    this.vmon = vmon;

  endfunction


  task tc1_reset_only();

    tb_logger::info("TEST_SUITE","TC1: Reset only");

    env.gen.repeat_count = 0;

    env.pre_test();

    repeat (10) @(posedge vdrv.clk);

  endtask


  task tc2_write_when_empty();

    tb_logger::info("TEST_SUITE","TC2: Write when empty");

    env.pre_test();
    env.start_agents();

    env.gen.repeat_count = `BUF_SIZE;

    env.gen.run();

    repeat (10) @(posedge vdrv.clk);

  endtask


  task tc3_read_when_empty();

    tb_logger::info("TEST_SUITE","TC3: Read when empty");

    env.pre_test();

    repeat (`BUF_SIZE) begin
      @(posedge vdrv.clk);
      vdrv.cb.wr <= 0;
      vdrv.cb.rd <= 1;
    end

    repeat (5) @(posedge vdrv.clk);

  endtask


  task tc4_write_until_full();

    tb_logger::info("TEST_SUITE","TC4: Write until full");

    env.pre_test();
    env.start_agents();

    while (!vmon.full) begin
      @(posedge vdrv.clk);
      vdrv.cb.wr <= 1;
      vdrv.cb.rd <= 0;
      vdrv.cb.datain <= $urandom;
    end

    repeat (5) @(posedge vdrv.clk);

  endtask


  task tc5_write_when_full();

    tb_logger::info("TEST_SUITE","TC5: Write when full");

    tc4_write_until_full();

    repeat (5) begin
      @(posedge vdrv.clk);
      vdrv.cb.wr <= 1;
      vdrv.cb.rd <= 0;
      vdrv.cb.datain <= $urandom;
    end

    repeat (5) @(posedge vdrv.clk);

  endtask


  task tc6_read_until_empty();

    tb_logger::info("TEST_SUITE","TC6: Read until empty");

    tc4_write_until_full();

    while (!vmon.empty) begin
      @(posedge vdrv.clk);
      vdrv.cb.wr <= 0;
      vdrv.cb.rd <= 1;
    end

    repeat (5) @(posedge vdrv.clk);

  endtask


  task tc7_simultaneous_wr_rd();

    tb_logger::info("TEST_SUITE","TC7: Simultaneous write/read");

    env.pre_test();
    env.start_agents();

    repeat (`BUF_SIZE/2) begin
      @(posedge vdrv.clk);
      vdrv.cb.wr <= 1;
      vdrv.cb.rd <= 0;
      vdrv.cb.datain <= $urandom;
    end

    repeat (16) begin
      @(posedge vdrv.clk);
      vdrv.cb.wr <= 1;
      vdrv.cb.rd <= 1;
      vdrv.cb.datain <= $urandom;
    end

    repeat (5) @(posedge vdrv.clk);

  endtask


  task tc8_full_to_empty();

    tb_logger::info("TEST_SUITE","TC8: Full to Empty");

    tc4_write_until_full();
    tc6_read_until_empty();

  endtask


  task tc9_empty_to_full();

    tb_logger::info("TEST_SUITE","TC9: Empty to Full");

    env.pre_test();
    tc4_write_until_full();

  endtask


  task tc10_random_ops();

    tb_logger::info("TEST_SUITE","TC10: Random operations");

    env.pre_test();
    env.start_agents();

    repeat (100) begin
      @(posedge vdrv.clk);
      vdrv.cb.wr <= $urandom_range(0,1);
      vdrv.cb.rd <= $urandom_range(0,1);
      vdrv.cb.datain <= $urandom;
    end

    repeat (10) @(posedge vdrv.clk);

  endtask

endclass
