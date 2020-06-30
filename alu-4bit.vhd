--4-bit arithmetic logic unit
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--operations:
--000 -> Result: nib_1 + nib_2     || Flag: Cout = Overflow || Desc: Addition
--001 -> Result: nib_1 - nib_2     || Flag: 1 iff nib_2 > nib_1, otherwise 0 || Desc: Test / diff
--010 -> Result: nib_1 & nib_2     || Flag: 0 || Desc: Bitwise AND
--011 -> Result: nib_1 | nib_2     || Flag: 0 || Desc: Bitwise OR
--100 -> Result: nib_1 ^ nib_2     || Flag: 0 || Desc: Bitwise XOR
--101 -> Result: 15 - nib_1        || Flag: 0 || Desc: Bitwise inverse nib_1
--110 -> Result: 15 - nib_2        || Flag: 0 || Desc: Bitwise inverse nib_2
--111 -> Result: nib_1 + nib_2 + 1 || Flag: Cout = Overflow || Desc: Addition

entity ALU is
	port(
		nib_1 : in std_logic_vector(3 downto 0); --4-bit input for first nibble
		nib_2 : in std_logic_vector(3 downto 0); --4-bit input for second nibble
		cout : out std_logic;
		flag : out std_logic; 
		result : out std_logic_vector(3 downto 0); --4-bit out
	);
end entity ALU;

--what it looks like
--		  +---------------+
--nib_1(3:0)    ->|		  |->cout
--nib_2(3:0)    ->|	 ALU      |->flag
--operation(2:0)->|               |->result(3:0)
--		  +---------------+

architecture behavior of ALU is
	signal temp: std_logic_vector(4 downto 0);
begin
--start implementation
	process(nib_1, nib_2, operation, temp) is
	begin
		flag <= '0'; --start with flag == 0
		--operations
		case operation is
		--first operation
		when "000" => 
			temp <= std_logic_vector((unsigned("0" & nib_1) + unsigned(nib_2)));
			result <= temp(3 downto 0);
			cout <= temp(4);
		--second operation	
		when "001" => 
			if (nib_1 >= nib_2) then
				result <= std_logic_vector(unsigned(nib_1) - unsigned(nib_2));
				flag <= '0'; --set flag to 0 if nib_1 greater
			else
				result <= std_logic_vector(unsigned(nib_2) - unsigned(nib_1));
				flag <= '1'; --set flag to 1 if nib_2 greater
			end if;
		--third operation	
		when "010" => 
			result <= nib_1 and nib_2;
		--fourth operation	
		when "011" => 
			result <= nib_1 or nib_2;
		--fifth operation
		when "100" =>
			result <= nib_1 xor nib_2;
		--sixth operation
		when "101" =>
			result <= not nib_1;
		--seventh operation
		when "110" =>
			result <= not nib_2;
		--last operation
		when others =>
			temp <= std_logic_vector((unsigned("0" & nib_1) + unsigned(not nib_2)) + 1);
			result <= temp(3 downto 0);
			flag <= temp(4);
		end case;
	end process;
end architecture behavior;
