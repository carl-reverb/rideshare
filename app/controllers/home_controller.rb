class HomeController < ApplicationController
  def index
    sql = %{SELECT
              CONCAT(d.first_name, ' ', d.last_name) AS driver_name,
              AVG(t.rating) AS avg_rating,
              COUNT(t.rating) AS trip_count
            FROM trips t
            JOIN users d ON t.driver_id = d.id
            GROUP BY t.driver_id, d.first_name, d.last_name
            ORDER BY COUNT(t.rating) DESC
    }
    @stats = ActiveRecord::Base.connection.execute(sql)
  end
end
