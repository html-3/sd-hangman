----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:37:31 07/14/2022 
-- Design Name: 
-- Module Name:    main - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity main is
    Port ( clk : in STD_LOGIC;
			  guess : in  STD_LOGIC_VECTOR (2 downto 0);
			  --lifes : out STD_LOGIC_VECTOR (1 downto 0);
           position : out STD_LOGIC_VECTOR (5 downto 0) := "000000";
			  send : in  STD_LOGIC);
end main;

architecture Behavioral of main is
type states is (s0, s1);
signal state : states := s0;
signal password : STD_LOGIC_VECTOR (17 downto 0) := "111001001110101000"; -- 711650 

begin

-- State machine 
process (clk, send)
	begin
		if rising_edge(clk) then
			case state is
				when s0 =>
					if send = '1' then
						state <= s1; -- If user sends guess
					else
						state <= s0; -- If user still didn't make guess
					end if;
				when s1 =>
					if send = '1' then
						state <= s1; -- If user sends guess
					else
						state <= s0; -- Waits for new guess
					end if;

			end case;
		end if;
	end process;

-- Output depending on the state
process (clk)
	begin
		if rising_edge(clk) then
			case state is
				when s0 =>
				
				when s1 =>
					
					pwloop:
					for i in 0 to 5 loop
						-- Here goes our hangman password validation
						if (password(3*i) NXOR guess(0) AND password(3*i+1) NXOR guess(1) AND password(3*i+2) NXOR guess(2)) then
							-- Save position where guess was correct
							-- Signal that no lifes should be removed
							position(i) <= '1';
							--safe <= '1';
						end if;
					end loop pwloop;
					
					-- Life reduction logic
								
				end case;
			end if;
		end process;
end Behavioral;

