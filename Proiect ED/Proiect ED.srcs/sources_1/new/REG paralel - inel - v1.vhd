library ieee; 

library work; 

use ieee.std_logic_1164.all; 

use ieee.std_logic_misc.all; 

use ieee.numeric_std.all; 

use ieee.std_logic_unsigned.all; 

entity reg_par is  

     port ( 
        
        selectie : in std_logic;
        selectie_deplasare: in std_logic;

        reset :  in std_logic; 

        clk :  in std_logic; 

        en: in std_logic;
        
        data_init :  in std_logic_vector( 7  downto 0  ); 

        result :  out std_logic_vector( 7  downto 0  ) ;
        
        bitin : in STD_LOGIC

    ); 

end entity;  

 

 

architecture rtl of reg_par is  

    signal aux: std_logic_vector(7 downto 0); 

    signal clk_in : std_logic; 

    signal Data : STD_LOGIC_VECTOR(7 downto 0) := "00000000";
    

    begin  

     process(clk)     

        variable n : integer range 0 to 1000000000; 

        begin 

        if clk'event and clk='1' then 

            if n < 100000000 then 

                n := n+1; 

            else 

                 n := 0; 

            end if; 

            if n <= 50000000 then 

                clk_in <= '1'; 

            else 

                clk_in <= '0'; 

            end if; 

        end if; 

    end process; 

       process(clk_in,reset,en,data_init, selectie)  

       begin  
          
       if selectie='0' then

            if reset = '0' then  

                aux<= "00000000" ;  

                else 

                    if (clk_in'EVENT and clk_in = '1') then   

                            aux <= data_init; 


                    end if;        

                end if; 

                result<=aux; 
                
         elsif selectie='1' then
         
            if(reset = '0') then    -- reset
                Data <= "00000000";
            else
                if(rising_edge(clk_in))then
                    if(selectie_deplasare = '0') then --deplasare stanga
                    
                        Data(7) <= Data(6);
                        Data(6) <= Data(5);
                        Data(5) <= Data(4);
                        Data(4) <= Data(3);
                    
                        Data(3) <= Data(2);
                        Data(2) <= Data(1);
                        Data(1) <= Data(0);
                        Data(0) <= bitin;
                    else    --deplasare dreapta
                        Data(0) <= Data(1);
                        Data(1) <= Data(2);
                        Data(2) <= Data(3);
                        Data(3) <= Data(4);
                    
                        Data(4) <= Data(5);
                        Data(5) <= Data(6);
                        Data(6) <= Data(7);
                        Data(7) <= bitin;
                    
                    end if;         
                end if;    
            end if;
         result<=Data;
         end if;
         
         

        end process; 

    end rtl;