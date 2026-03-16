class tb_logger;

  // verbosity control
  static int unsigned verbosity = 1;

  // set verbosity
  static function void set_verbosity(int unsigned v);
    verbosity = v;
    $display("[%0t] [TB_INFO] [LOGGER] verbosity=%0d", $time, verbosity);
  endfunction


  // info message
  static function void info(string comp, string msg);
    $display("[%0t] [TB_INFO] [%s] %s", $time, comp, msg);
  endfunction


  // debug message
  static function void debug(string comp, string msg);
    if (verbosity > 1) begin
      $display("[%0t] [TB_DBG ] [%s] %s", $time, comp, msg);
    end
  endfunction


  // warning message
  static function void warn(string comp, string msg);
    $display("[%0t] [TB_WARN] [%s] %s", $time, comp, msg);
  endfunction


  // error message
  static function void err(string comp, string msg);
    $error("[%0t] [TB_ERR] [%s] %s", $time, comp, msg);
  endfunction

endclass