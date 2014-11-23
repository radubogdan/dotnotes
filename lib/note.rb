require "note/version"

module Note
  class Application
    def initialize
      @notes_path = ENV['HOME'] + '/.notes'
    end

    def init
      Dir.mkdir @notes_path unless File.exists?(@notes_path)
    end

    def new filename
      file = File.open(@notes_path + "/#{filename}", "w")
      system("vi #{file.path}")
    end

    def show filename
      file_path = @notes_path + "/" + filename
      system("cat #{file_path}") if File.exists?(file_path)
    end

    def edit filename
      file_path = @notes_path + "/" + filename
      system("vi #{file_path}") if File.exists?(file_path)
    end

    def list
      system("stat #{@notes_path}/* -c \"%y %s %n\"")
    end

    def delete filename
      file_path = @notes_path + "/" + filename
      system("rm #{file_path}") if File.exists?(file_path)
    end
  end
end
