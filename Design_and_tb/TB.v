module  Auto_Garage_Door_Ctrl_TB ; 

reg UP_MAX    ; 
reg DN_MAX    ; 
reg Activate  ; 
reg clk , rst ;

wire UP_motor ; 
wire DN_motor ; 

Auto_Garage_Door_Ctrl DUT (.UP_MAX(UP_MAX) , .DN_MAX(DN_MAX) , .Activate(Activate) , .clk(clk) ,
                                    .rst(rst) , .UP_motor(UP_motor) , .DN_motor(DN_motor) );

initial begin
    clk = 0 ; 
    forever #2 clk = ~clk ; 
end

initial begin
    rst= 1 ; 
    UP_MAX = 0 ; 
    DN_MAX = 0 ; 
    Activate = 0 ;
    @(negedge clk);
    
    rst = 0 ; 
    Activate = 1 ; 
    repeat(1000) begin 
        UP_MAX = $random ; 
        DN_MAX = $random ; 
        @(negedge clk); 
    end

    Activate = 0 ; 
    repeat (50) begin 
        UP_MAX = $random ; 
        DN_MAX = $random ; 
        @(negedge clk); 
    end        
$stop ; 
end

initial begin 
    $monitor ("UP_max = %b  ; Down_max = %b ; ACTIVE = %b ;" , UP_MAX , DN_MAX , Activate) ; 
    $monitor ("UP_Motor = %b ; DW_Motor = %b ;" , UP_motor , DN_motor ) ; 
end
endmodule 