program test(fifo_if.DRV vdrv, fifo_if.MON vmon);

  environment env;
  fifo_test_suite ts;

  int tc;

  initial begin

    env = new(vdrv, vmon);
    ts  = new(env, vdrv, vmon);

    if(!$value$plusargs("TC=%d", tc))
      tc = 1;

    case(tc)
      1: ts.tc1_reset_only();
      2: ts.tc2_write_when_empty();
      3: ts.tc3_read_when_empty();
      4: ts.tc4_write_until_full();
      5: ts.tc5_write_when_full();
      6: ts.tc6_read_until_empty();
      7: ts.tc7_simultaneous_wr_rd();
      8: ts.tc8_full_to_empty();
      9: ts.tc9_empty_to_full();
      10: ts.tc10_random_ops();
    endcase

    $finish;

  end

endprogram