library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity pwm is
    generic(
        sys_freq    : integer := 50e6;
        pwm_freq    : integer := 100e3;
        pwm_bits    : integer := 4
    );
    port(
        clk_i   : in std_logic;
        rst_i   : in std_logic;
        ena_i   : in std_logic;
        duty_i  : in std_logic_vector(pwm_bits-1 downto 0);
        out_o   : out std_logic
    );
end;

architecture pwm_arq of pwm is
    -- Parte declarativa

    constant pwm_period : integer := sys_freq/pwm_freq;

    signal count        : integer range 0 to pwm_period - 1 := 0;
    signal half_duty    : integer range 0 to pwm_period/2 := 0;

begin
    -- Parte descriptiva

    process(clk_i, rst_i)
    begin
        if (rst_i = '1') then
            count <= 0;
            out_o <= '0';
        elsif rising_edge(clk_i) then
            if (ena_i = '1') then
                half_duty   <= to_integer(unsigned(duty_i))*pwm_period/(2**pwm_bits)/2;
            end if;
            if (count = pwm_period - 1) then
                count <= 0;
            else
                count <= count + 1;
            end if;
            if (count = half_duty) then
                out_o <= '0';
            elsif (count = pwm_period - half_duty) then
                out_o <= '1';
            end if;
        end if;
    end process;

end;
