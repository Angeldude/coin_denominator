module CoinConvert
    QUARTER_VALUE = 25
    DIME_VALUE = 10
    NICKEL_VALUE = 5
    PENNY_VALUE = 1

    def self.make_money(amount)
        amount
        .chars
        .reject{|x| x.eql?('.')}
        .join
        .to_i
    end
    
    def self.change_returned(amount)
        amount < 0 ? ["not enough"] : CoinConvert.denominations(amount)
    end
    
    def self.convert(result)
        # result = make_money(amount)
        penny(result)
    end

    def self.quarters(amount)
        {res: amount / QUARTER_VALUE, rem: amount % QUARTER_VALUE}
    end
    
    def self.dimes(amount)
        q = quarters(amount)
        d = q[:rem]
        {q: q[:res], d: d / DIME_VALUE, rem: d % DIME_VALUE}
    end

    def self.nickels(amount)
        coins = dimes(amount)
        n = coins[:rem]
        {q: coins[:q], d: coins[:d], n: n / NICKEL_VALUE, rem: n % NICKEL_VALUE }
    end

    def self.penny(amount)
        coins = nickels(amount)
        pe = coins[:rem]
        {q: coins[:q], d: coins[:d], n: coins[:n], p: pe}
    end   
    
    class Coin
        def initialize(amount)
            @amount = amount
        end  

        def count
            str = "#{@amount} #{self.class.name.split('::').last}"
            @amount < 2 ? str : str + 's'
        end
    end
    class Penny < Coin
        def count
            str = @amount.to_s
            @amount < 2 ? str + ' Penny' : str + " Pennies"
        end
    end

    class Quarter < Coin; end

    class Dime < Coin; end

    class Nickel < Coin; end

    def self.denominations price
        coins = convert(price)
        [ 
            Quarter.new(coins[:q]).count,
            Dime.new(coins[:d]).count,
            Nickel.new(coins[:n]).count,
            Penny.new(coins[:p]).count
        ]
    end

    private_class_method :quarters, :dimes, :nickels, :penny, :convert, :denominations
end