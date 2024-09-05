module Auto_Garage_Door_Ctrl (UP_MAX , DN_MAX , Activate , clk ,
                                    rst , UP_motor , DN_motor );

parameter  IDLE  = 2'b00 ;
parameter  Mv_UP = 2'b01 ;
parameter  Mv_DN = 2'b10 ;

input UP_MAX    ; 
input DN_MAX    ; 
input Activate  ; 
input clk , rst ;

output reg  UP_motor ; 
output reg  DN_motor ; 

reg [1:0] state , next_state ; 

// state memory  
always @(posedge clk or posedge rst) begin
    if(rst) 
        state <= IDLE ; 
    else 
        state <= next_state ; 
end

// states transitions 
always @(*) begin
    if(rst)
        next_state = IDLE ; 
    else begin 
        case (state) 
            IDLE : begin 
                if(Activate && DN_MAX && ~UP_MAX)
                    next_state = Mv_UP ; 
                else if(Activate && ~DN_MAX && UP_MAX)
                    next_state = Mv_DN ; 
                else 
                    next_state = IDLE ; 
            end
            Mv_UP : begin
                if(UP_MAX) 
                    next_state = IDLE ; 
                else 
                    next_state = Mv_UP ; 
            end
            Mv_DN : begin
                if(DN_MAX)
                    next_state = IDLE ;
                else 
                    next_state = Mv_DN ; 
            end
            default : next_state = IDLE ; 
        endcase 
end
end

// output 
always @(*) begin
    if(rst) begin 
        UP_motor = 0 ;
        DN_motor = 0 ; 
    end 
    else begin 
        case(state) 
            IDLE : begin 
                UP_motor = 0 ;
                DN_motor = 0 ; 
            end 
            Mv_UP : begin
                UP_motor = 1 ;
                DN_motor = 0 ;
            end
            Mv_DN : begin
                UP_motor = 0 ;
                DN_motor = 1 ;            
            end
            default : begin 
                UP_motor = 0 ;
                DN_motor = 0 ;
            end
        endcase 
    end
end

endmodule 