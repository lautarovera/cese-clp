library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity pwm_tb is
end;

architecture pwm_tb_arq of pwm_tb is

    component pwm is
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
    end component;

    constant sys_freq_tb: integer := 50e6;
    constant pwm_freq_tb: integer := 100e3;
    constant pwm_bits_tb: integer := 8;

    -- Declaracion de senales de prueba
    signal clk_tb: std_logic := '0';
    signal rst_tb: std_logic := '1';
    signal ena_tb: std_logic := '1';
    signal duty_tb: std_logic_vector(pwm_bits_tb-1 downto 0) := (others => '0');
    signal out_tb: std_logic := '0';

begin

    clk_tb  <= not clk_tb after 10 ns;
    rst_tb  <= '0' after 50 us;
    ena_tb  <= '0' after 150 us, '1' after 200 us, '0' after 900 us;
    duty_tb <= std_logic_vector(to_unsigned(26, pwm_bits_tb)) after 50 us,
               std_logic_vector(to_unsigned(52, pwm_bits_tb)) after 100 us,
               std_logic_vector(to_unsigned(128, pwm_bits_tb)) after 250 us,
               std_logic_vector(to_unsigned(255, pwm_bits_tb)) after 400 us,
               std_logic_vector(to_unsigned(212, pwm_bits_tb)) after 600 us,
               std_logic_vector(to_unsigned(174, pwm_bits_tb)) after 700 us,
               std_logic_vector(to_unsigned(100, pwm_bits_tb)) after 800 us;

    DUT: pwm
        generic map(
            sys_freq => sys_freq_tb,
            pwm_freq => pwm_freq_tb,
            pwm_bits => pwm_bits_tb
        )
        port map(
            clk_i   => clk_tb, 
            rst_i   => rst_tb,
            ena_i   => ena_tb,
            duty_i  => duty_tb,
            out_o   => out_tb
        );

end;
