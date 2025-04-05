library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tt_um_simon_says_karuin33 is
    port (
        knapp_comb   : in  std_logic_vector(1 downto 0);
        correct_out  : out std_logic;
        count_out    : out std_logic_vector(5 downto 0);
        --uio_in  : in  std_logic_vector(7 downto 0);
        --uio_out : out std_logic_vector(7 downto 0);
        --uio_oe  : out std_logic_vector(7 downto 0);
        --ena     : in  std_logic;
        clk     : in  std_logic;
        rst_n   : in  std_logic
    );
end tt_um_simon_says_karuin33;

architecture Behavioral of tt_um_simon_says_karuin33 is
    signal count           : unsigned(5 downto 0);
    signal timer           : unsigned(10 downto 0);
    signal knapp_comb_sync : std_logic_vector (1 downto 0);
    signal guess : std_logic_vector (5 downto 0);
    signal guess_sync, guess_sync_old, guess_ep : std_logic_vector (1 downto 0);
    signal guess_enable : std_logic;
    

begin
    process(clk) begin
        if rising_edge(clk) then
        guess_sync <= knapp_comb;
        guess_sync_old <= guess_sync;
        end if;
    end process;
    guess_ep <= guess_sync and not guess_sync_old;

    process(clk)
    begin
        if rising_edge(clk) then
            knapp_comb_sync <= knapp_comb;
        end if;
    end process;

    process(clk, rst_n)
    begin
        if rst_n = '0' then
            count <= to_unsigned(0, 6);
            guess <= "000000";
        elsif rising_edge(clk) then
            if knapp_comb_sync = "11" then
                guess_enable <= '1';
                if count = "111111" then
                    count <= to_unsigned(0, 6);
                else
                    count <= count + 1;
                end if;
            end if;

            --timer efter counter is done
            if knapp_comb_sync = "00" then
                if timer = "11111111111" then
                    timer <= to_unsigned(0, 11);
                    count_out <= (others => '0');
                else
                    timer <= timer + 1;
                    count_out <= std_logic_vector(count);
                end if;
            end if;
            --Shift process 
            if guess_ep = "01" then  --låg gissning
                guess <= guess(4 downto 0) & '0';
            elsif guess_ep = "10" then  --hög gissning
                guess <= guess(4 downto 0) & '1';
            end if;
            if guess_enable = '1' then
            if guess = std_logic_vector(count) then
                correct_out <= '1';
            else
                correct_out <= '0';
            end if;
            end if;
        end if;
    end process;



end Behavioral;