# frozen_string_literal: true

require_relative 'app_data'
require_relative 'ui/main_ui'

data = AppData.new
main_ui = MainUi.new data: data

# текстовый интерфейс для создания поезда тут
main_ui.menu
