require 'statemachine'

module Battleship

  module PlacementStatemachine

    def self.instance
      if @instance.nil?
        @instance = Statemachine.build do
          state :no_clicks do
            event :hover, :no_clicks, :highlight_sector
            event :click, :attempt_anchor
          end
          state :attempt_anchor do
            on_entry :attempt_anchor
            event :invlid_anchor, :no_clicks
            event :valid_anchor, :one_click
          end
          state :one_click do
            event :hover, :one_click, :highlight_placement
            event :click, :placement_attempt
          end
          state :placement_attempt do
            on_entry :attempt_placement
            event :invalid_placement, :no_clicks, :cancel_placement
            event :valid_placement, :completed, :place_ship
          end
          context PlacementContext.new
        end
      end
      return @instance
    end

    class PlacementContext

      attr_accessor :statemachine
      attr_reader :placement

      def reset(sectors, grid, length)
        @statemachine.reset
        @sectors = sectors
        @grid = grid
        @length = length

        @highlighted_sector = nil
        @orientation = nil
        @anchor = nil
        @placement = nil
      end

      def highlight_sector(sector)
        @highlighted_sector.unhighlight if @highlighted_sector
        @highlighted_sector = sector
        @highlighted_sector.highlight
      end

      def attempt_anchor(sector)
        coordinates = sector.coordinates
        if @grid[coordinates].ship.nil?
          @anchor = sector
          @statemachine.valid_anchor
        else
          @statemachine.invalid_anchor
        end
      end

      def highlight_placement(sector)
        slope = @anchor.slope_to(sector)
        orientation = slope < -1 ? :vertical : :horizontal
        if orientation != @orientation
          process_possible_placement(:unhighlight) if @orientation
          @orientation = orientation
          process_possible_placement(:highlight)
        end
      end

      def attempt_placement(sector)
        highlight_placement(sector)
        if @grid.valid_placement?(@anchor.coordinates, @orientation, @length)
          @statemachine.valid_placement
        else
          @statemachine.invalid_placement
        end
      end

      def cancel_placement
        process_possible_placement(:unhighlight) if @orientation
        @orientation = nil
        @anchor = nil
      end

      def place_ship
        process_possible_placement(:unhighlight)
        @placement = "#{@anchor.coordinates} #{@orientation}"
      end

      private #############################################

      def process_possible_placement(method)
        sector = @anchor
        (@length).times do
          break if sector.nil?
          sector.send(method)
          sector = @orientation == :vertical ? sector.down : sector.right
        end
      end
    end

  end

end