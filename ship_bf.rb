# commited

class Field

    def initialize
        @field = Array.new(10).map!{Array.new(10) {'*'}}
        @ships_count = [[4, 1],[3, 2],[2, 3],[1, 4]]
    end
    def display_field
        v = 0
        puts "    A B C D E F G H J K"
        puts "    -------------------" 
        for line in @field do
            puts "#{v} | #{line.join(' ')}"
            v += 1
        end
    end

    def place_ship
        @ships=[]
        for ship_weight_count in @ships_count do
            n = ship_weight_count[1]
            while n!=0 do
                ship = Ship.new(ship_weight_count[0])
                while !ship.place_valid?(@ships) do
                    ship.set_new_place
                end
                write_to_field(ship)
                @ships.append(ship)
                ship.cals_space_arround
                n-=1
            end
        end
    end

    def write_to_field(ship)
        @field[ship.head_place[0]][ship.head_place[1]] = ship.size
        for i in 1..ship.size-1 do
            @field[ship.head_place[0]+i*(1-ship.horizontal)][ship.head_place[1]+i*ship.horizontal] = ship.size
        end
    end
end



class Ship
    attr_accessor :size, :horizontal, :own_space, :space_arround
    def initialize (size)
        @size = size
        @head_place = Array.new(2)
        @horizontal
        set_new_place
    end

    def head_place
        @head_place
    end

    def head_place=(value)
        @head_place = value
    end

    def set_new_place
        @head_place = [rand(10), rand(10)]
        @horizontal = rand (2)
        calc_own_space
    end

    def place_valid?(ships)
        place_valid = true
        if @head_place[0] + (1-@horizontal) * size >= 10 || @head_place[1] + @horizontal * size >= 10
            place_valid = false
        elsif intersected?(ships)
            place_valid = false
        end
        place_valid
    end

    def intersected?(ships)
        
        intersected = false 
        for neibor_ship in ships do
            if @own_space.intersection(neibor_ship.own_space).size + @own_space.intersection(neibor_ship.space_arround).size > 0
                intersected = true              
            end
        end
        
        intersected
    end

    def calc_own_space
        @own_space = []
        @own_space.clear
        for i in 0..size-1 do
            own_space.append([@head_place[0]+i*(1-@horizontal), @head_place[1]+i*@horizontal])
        end
        @own_space
    end

    def cals_space_arround
        @space_arround = []

        if @horizontal == 1
            @space_arround.append([@own_space[0][0] - 1, @own_space[0][1] - 1])
            @space_arround.append([@own_space[0][0] + 1, @own_space[0][1] - 1])
            @space_arround.append([@own_space[0][0], @own_space[0][1] - 1])
            @space_arround.append([@own_space[-1][0] - 1, @own_space[-1][1] + 1])
            @space_arround.append([@own_space[-1][0] + 1, @own_space[-1][1] + 1])
            @space_arround.append([@own_space[-1][0], @own_space[-1][1] + 1])
            for position_from_own_space in @own_space
                @space_arround.append([position_from_own_space[0] - 1, position_from_own_space[1]])
                @space_arround.append([position_from_own_space[0] + 1, position_from_own_space[1]])
            end
        else
            @space_arround.append([@own_space[0][0] - 1, @own_space[0][1] - 1])
            @space_arround.append([@own_space[0][0] - 1, @own_space[0][1] + 1])
            @space_arround.append([@own_space[0][0] - 1, @own_space[0][1]])
            @space_arround.append([@own_space[-1][0] + 1, @own_space[-1][1] - 1])
            @space_arround.append([@own_space[-1][0] + 1, @own_space[-1][1] + 1])
            @space_arround.append([@own_space[-1][0] + 1, @own_space[-1][1]])
            for position_from_own_space in @own_space
                @space_arround.append([position_from_own_space[0], position_from_own_space[1] - 1])
                @space_arround.append([position_from_own_space[0], position_from_own_space[1] + 1])
            end
        end
    end
end

enemy_field = Field.new
enemy_field.place_ship
enemy_field.display_field
