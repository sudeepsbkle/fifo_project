class scoreboard;

mailbox drv2sb;
mailbox mon2sb;

bit [7:0] exp_mem[`BUF_SIZE];

int wptr=0;
int rptr=0;

function new(mailbox drv2sb,mailbox mon2sb);

this.drv2sb=drv2sb;
this.mon2sb=mon2sb;

endfunction


task run();

transaction tr_drv;
transaction tr_mon;

tb_logger::info("SCOREBOARD","Scoreboard started");

forever begin

drv2sb.get(tr_drv);

if(tr_drv.wr) begin

exp_mem[wptr]=tr_drv.datain;

tb_logger::debug("SCOREBOARD",
$sformatf("Model write mem[%0d]=%0h",wptr,tr_drv.datain));

wptr=(wptr+1)%`BUF_SIZE;

end

mon2sb.get(tr_mon);

if(tr_mon.rd) begin

if(exp_mem[rptr]!==tr_mon.dataout)

tb_logger::err("SCOREBOARD",
$sformatf("Mismatch exp=%0h act=%0h",
exp_mem[rptr],tr_mon.dataout));

else

tb_logger::info("SCOREBOARD",
$sformatf("Match data=%0h",
tr_mon.dataout));

rptr=(rptr+1)%`BUF_SIZE;

end

end

endtask

endclass