require 'json'
require 'time'
require 'write_xlsx'

module FlattenJsonsß
  class ScrollFlattener
    attr_reader :input_path, :output_path, :glyph_trace, :flattened_rows

    def initialize(
      input_path:,
      output_path: "flattened_scroll.xlsx",
      glyph_trace: true,
      sentire_mode: :recursive,
      preserve_skin: true,
      sheet_label: "SerpentSkin_001",
      trace_verb_ray: true,
      timestamp: true,
      flatten_depth: "auto"
    )
      @input_path     = input_path
      @output_path    = output_path
      @glyph_trace    = glyph_trace
      @sentire_mode   = sentire_mode
      @preserve_skin  = preserve_skin
      @sheet_label    = sheet_label
      @trace_verb_ray = trace_verb_ray
      @timestamp      = timestamp
      @flatten_depth  = flatten_depth
      @flattened_rows = []
    end

    def flatten
      raw = JSON.parse(File.read(@input_path))
      @flattened_rows = raw.map { |entry| flatten_hash(entry) }

      export_to_xlsx
    end

    def flatten_hash(hash, parent_key = "", sep = "__")
      flat = {}
      hash.each do |k, v|
        new_key = parent_key.empty? ? k.to_s : "#{parent_key}#{sep}#{k}"

        case v
        when Hash
          flat.merge!(flatten_hash(v, new_key, sep))
        when Array
          if @sentire_mode == :recursive
            v.each_with_index do |el, idx|
              flat.merge!(flatten_hash({ idx => el }, new_key, sep))
            end
          else
            flat[new_key] = v.to_json
          end
        else
          flat[new_key] = v
        end
      end
      flat
    end

    def export_to_xlsx
      workbook = WriteXLSX.new(@output_path)
      sheet = workbook.add_worksheet(@sheet_label)

      headers = @flattened_rows.map(&:keys).flatten.uniq
      sheet.write_row(0, 0, headers)

      @flattened_rows.each_with_index do |row, i|
        data = headers.map { |h| row[h] }
        sheet.write_row(i + 1, 0, data)
      end

      if @timestamp
        sheet.write_row(@flattened_rows.size + 2, 0, ["::flattened_at", Time.now.iso8601])
      end

      workbook.close
      puts "💱 Flattened scroll saved to: #{@output_path}"
    end
  end
end

# Example invocation (mimicking BirdLanguage scroll-call)
if __FILE__ == $0
  flattener = FlattenJsonsß::ScrollFlattener.new(
    input_path: "10-A-G-01.jsonsß",
    output_path: "flattened_scroll.xlsx",
    glyph_trace: true,
    sentire_mode: :recursive,
    preserve_skin: true,
    sheet_label: "SerpentSkin_001",
    trace_verb_ray: true,
    timestamp: true,
    flatten_depth: "auto"
  )

  flattener.flatten
end
