require "note/version"

# Don't overwrite default Exceptions but use them
class NoteAlreadyExist < StandardError; end
class NoteNotExist < StandardError; end

module Note
  class Application

    def initialize
      @notes_path = ENV['HOME'] + '/.notes'
    end

    def initialized? p={}
      path = @notes_path + "/" + p[:file].to_s
      File.exists?(path)
    end

    # Create a new note in notes path
    # filename is the name of the note
    #
    # @example
    # begin
    #   note.new(name)
    # rescue NoteAlreadyExist
    #   puts "the note already exist
    # rescue UninitializedNotesPath
    #   puts "note.init must be run first"
    # end
    def new filename
      Dir.mkdir @notes_path unless initialized?

      if initialized?(file: filename)
        raise NoteAlreadyExist
      else
        file = File.open(@notes_path + "/#{filename}", "w")
        system("vi #{file.path}")
      end
    end

    # Display contents of an existing note
    # filename is the name of the note
    #
    # @example
    # note.show(name)
    def show filename
      file_path = @notes_path + "/" + filename
      system("cat #{file_path}") if initialized?(file: filename)
    end

    # Edit a note
    # filename is the name of the note
    #
    # @example
    # note.show(name)
    def edit filename
      file_path = @notes_path + "/" + filename
      if initialized?(file: filename)
        system("vi #{file_path}")
      else
        raise NoteNotExist
      end
    end

    # Show all notes
    def list
      system("stat #{@notes_path}/* -c \"%y %s %n\"") unless Dir[@notes_path + "/*"].empty?
    end

    # Delete a note
    # filename is the name of the note
    #
    # @example
    # note.delete(name)
    def delete filename
      file_path = @notes_path + "/" + filename
      if initialized?(file: filename)
        system("rm #{file_path}")
      else
        raise NoteNotExist
      end
    end

    # Find a keyword in a note
    def find keyword
      system("find #{@notes_path} -type f -print0 | xargs -0 grep -li #{keyword}")
    end

    def help
      puts ""
      puts "Commands:"
      puts "  note new {filename}    # Create a new note with filename"
      puts "  note show {filename}   # Display a note"
      puts "  note edit {filename}   # Edit a note"
      puts "  note delete {filename} # Delete a note"
      puts "  note list              # List all notes"
      puts "  note help              # Display this help"
      puts ""
    end
  end
end
