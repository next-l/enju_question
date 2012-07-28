module EnjuQuestion
  module Generators
    class ViewsGenerator < Rails::Generators::Base
      source_root File.expand_path('../../../../app/views', __FILE__)

      def copy_files
        directories = %w(
          answers
          questions
        )

        directories.each do |dir|
          directory dir, "app/views/#{dir}"
        end
      end
    end
  end
end
