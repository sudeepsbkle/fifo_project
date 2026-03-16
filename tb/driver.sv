class driver;

virtual fifo_if.DRV vif;

mailbox gen2drv;
mailbox drv2sb;

function new(
virtual fifo_if.DRV vif,
mailbox gen2drv,
mailbox drv2sb
);

this.vif=vif;
this.gen2drv=gen2drv;
this.drv2sb=drv2sb;

endfunction


task reset();

tb_logger::info("DRIVER","Applying reset");

vif.cb.wr<=0;
vif.cb.rd<=0;
vif.cb.datain<=0;

repeat(5) @(posedge vif.clk);

endtask


task drive();

transaction tr;

forever begin

gen2drv.get(tr);

@(posedge vif.clk);

vif.cb.wr<=tr.wr;
vif.cb.rd<=tr.rd;
vif.cb.datain<=tr.datain;

tb_logger::debug("DRIVER",
$sformatf("Driving wr=%0d rd=%0d data=%0h",
tr.wr,tr.rd,tr.datain));

drv2sb.put(tr);

end

endtask

endclass