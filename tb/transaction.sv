class transaction;

rand bit wr;
rand bit rd;
rand bit [7:0] datain;

bit [7:0] dataout;
bit empty, full;

function void display(string msg);
$display("%0t %s wr=%0b rd=%0b din=%0h dout=%0h",
$time,msg,wr,rd,datain,dataout);
endfunction

endclass