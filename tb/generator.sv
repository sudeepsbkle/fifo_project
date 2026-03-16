class generator;

mailbox gen2drv;
int repeat_count = 10;

function new(mailbox gen2drv);
this.gen2drv = gen2drv;
endfunction

task run();

transaction tr;

repeat(repeat_count) begin

tr = new();
void'(tr.randomize());

tb_logger::debug("GENERATOR",
$sformatf("Generated wr=%0d rd=%0d datain=%0h",
tr.wr,tr.rd,tr.datain));

gen2drv.put(tr);

tr.display("GEN");

end

tb_logger::info("GENERATOR","Generation completed");

endtask

endclass