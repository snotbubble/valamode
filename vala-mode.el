;;; vala-mode.el

;; mode for Vala: https://vala.dev
;; by c.p.brown 2022~2024
;; acknowledgments above relevant code below
;;
;; do not use this mode, it is a derrived work for my own use,
;; and may contain elisp errors, has missing words, and definitely fights with emacs

(defvar vala nil "Support for the Vala programming language, <https://vala.dev>")

;; face definition based on this tutorial by Xah Lee:
;; http://xahlee.info/emacs/emacs/elisp_syntax_coloring.html

(defvar vala-cairocmd-face 'vala-cairocmd-face)
(defvar vala-cairoobj-face 'vala-cairoobj-face)
(defvar vala-cairoprop-face 'vala-cairoprop-face)
(defvar vala-comment-face 'vala-comment-face)
(defvar vala-comparison-face 'vala-comparison-face)
(defvar vala-constant-face 'vala-constant-face)
(defvar vala-context-face 'vala-context-face)
(defvar vala-control-face 'vala-control-face)
(defvar vala-datatype-face 'vala-datatype-face)
(defvar vala-datetime-face 'vala-datetime-face)
(defvar vala-event-face 'vala-event-face)
(defvar vala-gtkcmd-face 'vala-gtkcmd-face)
(defvar vala-gtkobj-face 'vala-gtkobj-face)
(defvar vala-gtkprop-face 'vala-gtkprop-face)
(defvar vala-help-face 'vala-help-face)
(defvar vala-io-face 'vala-io-face)
(defvar vala-logic-face 'vala-logic-face)
(defvar vala-math-face 'vala-math-face)
(defvar vala-modifier-face 'vala-modifier-face)
(defvar vala-series-face 'vala-series-face)
(defvar vala-specialstring-face 'vala-specialstring-face)
(defvar vala-system-face 'vala-system-face)
(defvar vala-var-face 'vala-var-face)

(defface vala-cairocmd-face '((t (:foreground "#527BCC" :weight bold))) "cairo commands" :group 'vala-mode)
(defface vala-cairoobj-face '((t (:foreground "#6C7ED9" :weight bold))) "cairo objects" :group 'vala-mode)
(defface vala-cairoprop-face '((t (:foreground "#3EB2B3" :weight bold))) "cairo object properties" :group 'vala-mode)
(defface vala-comment-face '((t (:foreground "#3EB365" :weight bold))) "comments" :group 'vala-mode)
(defface vala-comparison-face '((t (:foreground "#D9662B" :weight bold))) "comparison" :group 'vala-mode)
(defface vala-constant-face '((t (:foreground "#9966CC" :weight bold))) "constants" :group 'vala-mode)
(defface vala-context-face '((t (:foreground "#3EB38C" :weight bold))) "context" :group 'vala-mode)
(defface vala-control-face '((t (:foreground "#FF4D4D" :weight bold))) "control" :group 'vala-mode)
(defface vala-datatype-face '((t (:foreground "#7F6CD9" :weight bold))) "datatypes" :group 'vala-mode)
(defface vala-datetime-face '((t (:foreground "#89B336" :weight bold))) "datetime" :group 'vala-mode)
(defface vala-event-face '((t (:foreground "#CC7B29" :weight bold))) "events" :group 'vala-mode)
(defface vala-gtkcmd-face '((t (:foreground "#527BCC" :weight bold))) "gtk commands" :group 'vala-mode)
(defface vala-gtkobj-face '((t (:foreground "#6C7ED9" :weight bold))) "gtk objects" :group 'vala-mode)
(defface vala-gtkprop-face '((t (:foreground "#3EB2B3" :weight bold))) "gtk object properties" :group 'vala-mode)
(defface vala-help-face '((t (:foreground "#599C36" :weight bold))) "help" :group 'vala-mode)
(defface vala-io-face '((t (:foreground "#BF8C26" :weight bold))) "io" :group 'vala-mode)
(defface vala-logic-face '((t (:foreground "#CC5C95" :weight bold))) "logic" :group 'vala-mode)
(defface vala-math-face '((t (:foreground "#E64D2E" :weight bold))) "math" :group 'vala-mode)
(defface vala-modifier-face '((t (:foreground "#BF609F" :weight bold))) "modifiers" :group 'vala-mode)
(defface vala-series-face '((t (:foreground "#CC5C81" :weight bold))) "series" :group 'vala-mode)
(defface vala-specialstring-face '((t (:foreground "#E65C73" :weight bold))) "specialstring" :group 'vala-mode)
(defface vala-system-face '((t (:foreground "#B3B22D" :weight bold))) "system" :group 'vala-mode)
(defface vala-var-face '((t (:foreground "#B35147" :weight bold))) "user variables" :group 'vala-mode)

(defconst vala-comparison-words '("not" "or" "xor" "compare"))
(defconst vala-context-words '("public" "private" "context" "var" "construct"))
(defconst vala-control-words 
	'(
		"break" 
		"case" 
		"catch" 
		"continue" 
		"default" 
		"do" 
		"else" 
		"for" 
		"foreach" 
		"if" 
		"in" 
		"next" 
		"repeat" 
		"return" 
		"switch" 
		"throw" 
		"try" 
		"while" 
	)
)
(defconst vala-help-words '("prin" "print" "printf"))
(defconst vala-logic-words '("true" "false"))
(defconst vala-datatype-words 
	'(
		"bool"
		"char"
		"class"
		"double"
		"float"
		"int"
		"int64"
		"null"
		"out" 
		"size_t" 
		"string"
		"StringBuilder" 
		"struct" 
		"uint" 
		"uint8" 
		"uint16" 
		"uint32" 
		"uint64" 
		"unichar" 
		"void"
	)
)
(defconst vala-math-words '("sqrt" "min" "max" "abs" "floor" "ceil" "round"))
(defconst vala-io-words 
	'(
		"Dir" 
		"Document" 
		"ExtractFlags" 
		"File" 
		"FileCreateFlags" 
		"FileOutputStream" 
		"FileQueryInfoFlags" 
		"FileStream" 
		"FileTest" 
		"FileType" 
		"FileUtils" 
		"Path" 
		"Pid" 
		"Read" 
		"Result" 
		"SpawnError" 
		"SpawnFlags" 
		"WriteDisk" 
		"append_to" 
		"build_filename" 
		"create_dests_tree"
		"delete" 
		"errno" 
		"error_string" 
		"find_dest"
		"from_file" 
		"get_attachments"
		"get_author"
		"get_basename" 
		"get_creation_date"
		"get_creation_date_time"
		"get_creator"
		"get_current_dir" 
		"get_dirname" 
		"get_form_field"
		"get_id"
		"get_keywords"
		"get_metadata"
		"get_modification_date"
		"get_modification_date_time"
		"get_n_attachments"
		"get_n_pages"
		"get_n_signatures"
		"get_page"
		"get_page_by_label"
		"get_page_layout"
		"get_page_mode"
		"get_path" 
		"get_pdf_conformance"
		"get_pdf_part"
		"get_pdf_subtype"
		"get_pdf_subtype_string"
		"get_pdf_version"
		"get_pdf_version_string"
		"get_permissions"
		"get_print_duplex"
		"get_print_n_copies"
		"get_print_page_ranges"
		"get_print_scaling"
		"get_producer"
		"get_signature_fields"
		"get_subject"
		"get_text" 
		"get_title"
		"get_uri" 
		"has_attachments"
		"has_javascript"
		"is_linearized"
		"load_contents" 
		"make_directory_with_parents" 
		"message" 
		"new_for_path" 
		"next_header" 
		"open" 
		"open_filename" 
		"query_exists" 
		"query_file_type" 
		"read_data_block" 
		"read_line" 
		"read_name" 
		"reset_form"
		"save"
		"save_a_copy"
		"save_to_fd"
		"set_author"
		"set_creation_date"
		"set_creator"
		"set_filename" 
		"set_keywords"
		"set_modification_date"
		"set_modification_date_time"
		"set_options" 
		"set_producer"
		"set_standard_lookup" 
		"set_subject"
		"set_title"
		"spawn_async" 
		"spawn_sync" 
		"support_filter_all" 
		"support_format_all" 
		"write" 
		"write_data_block" 
		"write_header" 
	)
)
(defconst vala-series-words '("join" "joinv" "length" "resize"))
(defconst vala-specialstring-words 
	'(
		"@get"
		"_chomp"
		"_chug"
		"_delimit"
		"_strip"
		"ascii_casecmp"
		"ascii_down"
		"ascii_ncasecmp"
		"ascii_up"
		"canon"
		"casefold"
		"char_count"
		"chomp"
		"chr"
		"chug"
		"collate"
		"collate_key"
		"collate_key_for_filename"
		"compress"
		"concat"
		"contains" 
		"data" 
		"delimit"
		"down"
		"dup"
		"erase" 
		"escape"
		"first_index_of"
		"get_char"
		"get_char_validated"
		"get_next_char"
		"get_prev_char"
		"has_prefix"
		"has_suffix"
		"hash" 
		"index_of"
		"index_of_char"
		"index_of_nth_char"  
		"insert" 
		"is_ascii"
		"isdigit"
		"join"
		"last_index_of"
		"last_index_of_char"
		"len"
		"locale_to_utf8"
		"make_valid"
		"match_string"
		"ndup"
		"next_char"
		"nfill"
		"normalize"
		"offset"
		"pointer_to_offset"
		"prev_char" 
		"prepend" 
		"rchr"
		"replace" 
		"reverse" 
		"rstr"
		"rstr_len"
		"scanf"
		"set_str"
		"size"
		"sizeof" 
		"skip"
		"slice"
		"splice"
		"split" 
		"split_set"
		"str"
		"strcmp" 
		"strip"
		"substring" 
		"to_ascii"
		"to_bool"
		"to_double"
		"to_int"
		"to_int64"
		"to_long"
		"to_string"
		"to_uint64"
		"to_ulong"
		"to_utf16"
		"to_utf32"
		"to_utf32_fast"
		"to_utf8"
		"tokenize_and_fold"
		"trim" 
		"up"
		"utf8_offset"
		"valid_char"
		"validate"
		"validate_len"
		"vprintf"
	)
)
(defconst vala-system-words 
	'(
		"ApplicationFlags" 
		"Archive" 
		"Cairo" 
		"Display" 
		"Environment" 
		"Error" 
		"EventControllerMotion" 
		"EventControllerScroll" 
		"EventControllerZoom" 
		"free" 
		"GLib" 
		"Gdk" 
		"GestureClick" 
		"GestureDrag" 
		"GestureZoom" 
		"get_max_threads" 
		"get_max_unused_threads" 
		"get_num_processors" 
		"get_num_threads" 
		"get_num_unused_threads" 
		"Gtk" 
		"Math" 
		"Orientation" 
		"Pango" 
		"Process" 
		"Poppler"
		"RGBA" 
		"application" 
		"application_id" 
		"args" 
		"flags" 
		"get_default" 
		"init" 
		"main" 
		"main_quit" 
		"move_to_front" 
		"new" 
		"read_line" 
		"ref" 
		"run" 
		"set_max_idle_time"
		"set_max_unused_threads"
		"spawn_async" 
		"stop_unused_threads"
		"ThreadPool" 
		"unprocessed" 
		"using" 
		"weak" 
		"with_owned_data" 
	)
)
(defconst vala-datetime-words 
	'(
		"Date" 
		"DateDay" 
		"DateMonth" 
		"DateTime" 
		"DateWeekday" 
		"DateYear" 
		"add_days" 
		"add_months" 
		"date" 
		"days_between" 
		"get_day" 
		"get_monotonic_time" 
		"get_month" 
		"get_real_time" 
		"get_weekday" 
		"get_year" 
		"month" 
		"now" 
		"now_local" 
		"precise" 
		"second" 
		"set_day" 
		"set_dmy" 
		"set_month" 
		"set_year" 
		"strftime" 
		"subtract_days" 
		"subtract_months" 
		"time" 
		"valid" 
		"weekday" 
		"year" 
	)
)
(defconst vala-gtkcmd-words 
	'(
		"add_class" 
		"add_controller" 
		"add_events" 
		"add_provider" 
		"add_provider_for_display" 
		"add_titled" 
		"append" 
		"append_page" 
		"append_text" 
		"attach" 
		"bind_model" 
		"from_icon_name" 
		"get_active" 
		"get_allocated_height" 
		"get_allocated_width" 
		"get_ancestor" 
		"get_approximate_digit_width" 
		"get_child" 
		"get_child_at_index" 
		"get_css_classes" 
		"get_current_button" 
		"get_current_page" 
		"get_default_size" 
		"get_first_child" 
		"get_font_description" 
		"get_gutter" 
		"get_index" 
		"get_language" 
		"get_last_child" 
		"get_line_count" 
		"get_metrics"               
		"get_next_sibling" 
		"get_orientation" 
		"get_pango_context" 
		"get_parent" 
		"get_preferred_size" 
		"get_prev_sibling" 
		"get_row_at_index" 
		"get_scheme" 
		"get_selected" 
		"get_selected_row" 
		"get_size" 
		"get_start_child" 
		"get_string" 
		"get_style_context" 
		"get_value" 
		"hsv_to_rgb" 
		"insert" 
		"insert_before" 
		"load_from_data" 
		"load_from_string" 
		"popdown" 
		"popup" 
		"present" 
		"qsort_with_data" 
		"queue_draw" 
		"remove" 
		"reorder_child_after" 
		"reorder_child_before" 
		"rgb_to_hsv" 
		"set_active" 
		"set_baseline_row" 
		"set_button" 
		"set_child" 
		"set_column_spacing" 
		"set_css_classes" 
		"set_default_size" 
		"set_draw_func" 
		"set_end_child" 
		"set_halign" 
		"set_hexpand" 
		"set_highlight_syntax" 
		"set_icon_name" 
		"set_label" 
		"set_language" 
		"set_margin_bottom" 
		"set_margin_end" 
		"set_margin_start" 
		"set_margin_top" 
		"set_markup" 
		"set_max_width_chars" 
		"set_min_content" 
		"set_model" 
		"set_monospace" 
		"set_orientation" 
		"set_overlay_scrolling" 
		"set_parent" 
		"set_policy" 
		"set_position" 
		"set_row_spacing" 
		"set_selected" 
		"set_selection_mode" 
		"set_sensitive"
		"set_show_border" 
		"set_shrink_end_child" 
		"set_size_request" 
		"set_spacing" 
		"set_stack" 
		"set_style_scheme" 
		"set_tab" 
		"set_tab_pos" 
		"set_tabs" 
		"set_text" 
		"set_title" 
		"set_title_widget" 
		"set_titlebar" 
		"set_tooltip" 
		"set_transition_type" 
		"set_value" 
		"set_vexpand" 
		"set_visible" 
		"set_visible_child" 
		"set_width_chars" 
		"set_wrap_width" 
		"show" 
		"show_all" 
		"show_close_button" 
		"show_title_buttons" 
		"typeof" 
		"units_to_double" 
		"unparent" 
	)
)
(defconst vala-gtkobj-words 
	'(
		"ActionBar" 
		"Adjustment" 
		"Application" 
		"ApplicationWindow" 
		"Box" 
		"Buffer" 
		"Button" 
		"ComboBox" 
		"ComboBoxText" 
		"CssProvider" 
		"DrawingArea" 
		"DropDown" 
		"Entry" 
		"EventBox" 
		"FlowBox" 
		"Grid" 
		"GtkSource" 
		"Gutter" 
		"HeaderBar" 
		"Image" 
		"Label" 
		"LanguageManager" 
		"ListBox" 
		"MenuButton" 
		"Notebook" 
		"Object" 
		"Paned" 
		"Picture" 
		"Popover" 
		"Requisition" 
		"Scale" 
		"ScrollDirection" 
		"ScrolledWindow" 
		"SpinButton" 
		"Stack" 
		"StackSwitcher" 
		"StackTransitionType" 
		"StringList" 
		"StringObject" 
		"StyleContext" 
		"StyleSchemeManager" 
		"TabArray" 
		"TextTagTable" 
		"TextView" 
		"ToggleButton" 
		"ToolButton" 
		"View" 
		"Widget" 
		"Window"
		"space_drawer"
		"this"   
	)
)
(defconst vala-gtkprop-words 
	'(
		"accepts_tab" 
		"active" 
		"adjustment" 
		"alpha" 
		"border_width" 
		"bottom_margin" 
		"buffer" 
		"can_shrink" 
		"column_spacing" 
		"css_classes" 
		"default_width" 
		"default_height" 
		"enable_matrix" 
		"end_child" 
		"has_arrow" 
		"height_request" 
		"hexpand" 
		"highlight_current_line" 
		"homogeneous" 
		"icon_name" 
		"indent_on_tab" 
		"indent_width" 
		"keep_aspect_ratio" 
		"label" 
		"left_margin" 
		"lower" 
		"margin" 
		"margin_bottom" 
		"margin_end" 
		"margin_start" 
		"margin_top" 
		"markup" 
		"max_children_per_line" 
		"min_children_per_line" 
		"override_background_color" 
		"pack_end" 
		"pack_start" 
		"popover" 
		"position" 
		"resize_end_child" 
		"resize_start_child" 
		"right_margin" 
		"row_spacing" 
		"selected" 
		"selected_item" 
		"show_line_numbers" 
		"spacing" 
		"start_child" 
		"tab_width" 
		"text" 
		"title" 
		"top_margin" 
		"upper" 
		"value" 
		"vexpand" 
		"visible" 
		"wide_handle" 
		"width_request" 
		"with_buffer" 
		"with_entry" 
		"with_label" 
		"with_range" 
		"with_value" 
		"wrap_width" 
		"xalign" 
	)
)
(defconst vala-constant-words 
	'(
		"ACL" 
		"ALWAYS" 
		"BAD_WEEKDAY" 
		"BOLD" 
		"BOTTOM" 
		"BUTTON1_MOTION_MASK" 
		"BUTTON2_MOTION_MASK" 
		"BUTTON3_MOTION_MASK" 
		"BUTTON_PRESS_MASK" 
		"BUTTON_RELEASE_MASK" 
		"CAPTURE" 
		"DIRECTORY" 
		"DOWN" 
		"END" 
		"EPSILON" 
		"FFLAGS" 
		"FLAGS_NONE" 
		"FRIDAY" 
		"HORIZONTAL" 
		"IS_DIR" 
		"LEFT" 
		"MONDAY" 
		"NEVER" 
		"NONE" 
		"NORMAL" 
		"OK" 
		"PERM" 
		"POINTER_MOTION_MASK" 
		"PRELIGHT" 
		"PRIVATE" 
		"RIGHT" 
		"ROUND" 
		"SATURDAY" 
		"SCROLL_MASK" 
		"SEARCH_PATH" 
		"SELECTED" 
		"SLIDE_LEFT_RIGHT" 
		"SQUARE" 
		"START" 
		"STYLE_PROVIDER_PRIORITY_USER" 
		"SUNDAY" 
		"THURSDAY" 
		"TIME" 
		"TOP" 
		"TOUCH_BEGIN" 
		"TOUCH_END" 
		"TOUCH_MASK" 
		"TUESDAY" 
		"UP" 
		"VERTICAL" 
		"WEDNESDAY" 
		"black" 
		"blue" 
		"cyan" 
		"green" 
		"magenta" 
		"red" 
		"white" 
		"yellow" 
	)
)
(defconst vala-event-words 
	'(
		"EventMask" 
		"Gesture" 
		"GestureMultiPress" 
		"activate" 
		"activated" 
		"activated" 
		"activated" 
		"begin" 
		"button_press" 
		"button_press_event" 
		"button_release" 
		"changed" 
		"clicked" 
		"close_request" 
		"connect" 
		"destroy" 
		"drag_begin" 
		"drag_end" 
		"drag_update" 
		"end" 
		"event" 
		"motion" 
		"motion_notify" 
		"notify" 
		"pressed" 
		"released" 
		"scroll" 
		"selected" 
		"stopped" 
		"switch_page" 
		"toggled" 
		"touch" 
		"update" 
		"value_changed" 
	)
)
(defconst vala-cairocmd-words 
	'(
		"close_path" 
		"fill" 
		"line_to"
		"move_to" 
		"paint" 
		"queue_draw" 
		"select_font_face" 
		"set_font_size" 
		"set_line_cap" 
		"set_line_width" 
		"set_source_rgba" 
		"show_text" 
		"stroke" 
	)
)
(defconst vala-cairoobj-words '("rectangle" "line" "arc"))
(defconst vala-cairoprop-words '("TextExtents" "FontSlant" "FontWeight" "height" "text_extents" "LineCap" "width"))
(defconst vala-modifier-words '("parse" "to_string" "try_parse"))

(defconst vala-font-lock-keywords
	(list
		`(,(regexp-opt vala-logic-words 'words) . vala-logic-face)
		`(,(regexp-opt vala-gtkcmd-words 'words) . vala-gtkcmd-face)
		`(,(regexp-opt vala-gtkprop-words 'words) . vala-gtkprop-face)
		`(,(regexp-opt vala-cairoprop-words 'words) . vala-cairoprop-face)
		`(,(regexp-opt vala-event-words 'words) . vala-event-face)
		`(,(regexp-opt vala-comparison-words 'words) . vala-comparison-face)
		`(,(regexp-opt vala-context-words 'words) . vala-context-face)
		`(,(regexp-opt vala-io-words 'words) . vala-io-face)
		`(,(regexp-opt vala-system-words 'words) . vala-system-face)
		`(,(regexp-opt vala-help-words 'words) . vala-help-face)
		`(,(regexp-opt vala-math-words 'words) . vala-math-face)
		`(,(regexp-opt vala-specialstring-words 'words) . vala-specialstring-face)
		`(,(regexp-opt vala-gtkobj-words 'words) . vala-gtkobj-face)
		`(,(regexp-opt vala-control-words 'words) . vala-control-face)
		`(,(regexp-opt vala-datatype-words 'words) . vala-datatype-face)
		`(,(regexp-opt vala-datetime-words 'words) . vala-datetime-face)
		`(,(regexp-opt vala-series-words 'words) . vala-series-face)
		`(,(regexp-opt vala-constant-words 'words) . vala-constant-face)
		`(,(regexp-opt vala-cairocmd-words 'words) . vala-cairocmd-face)
		`(,(regexp-opt vala-cairoobj-words 'words) . vala-cairoobj-face)
		`(,(regexp-opt vala-modifier-words 'words) . vala-modifier-face)
	)
)

(defconst vala-mode-syntax-table
	(let 
		(
			(table (make-syntax-table))
		)
		;(modify-syntax-entry ?\  "_" table)
		(modify-syntax-entry ?\n ">" table)
		(modify-syntax-entry ?* ". 23b" table)
		(modify-syntax-entry ?/ ". 124" table)
		;; braces
		(modify-syntax-entry ?\[ "(]" table)
		(modify-syntax-entry ?\] ")[" table)
		(modify-syntax-entry ?\( "()" table)
		(modify-syntax-entry ?\) ")(" table)
		(modify-syntax-entry ?\{ "(}" table)
		(modify-syntax-entry ?\} "){" table)
		;; char
		(modify-syntax-entry ?\" "\'" table)
		;; string
		(modify-syntax-entry ?\" "\"" table)
		(modify-syntax-entry ?\\ "\\" table)
		;; words
		(modify-syntax-entry ?_ "w" table)
		;; not words
		(modify-syntax-entry ?, "." table)
		(modify-syntax-entry ?\; "." table)
		;; doesn't work
		(modify-syntax-entry ?> "." table)
		(modify-syntax-entry ?< "." table)
		table
	)
)

(defvar vala-mode-hook nil "hook for vala-mode")

;;;###autoload
(defun vala-mode ()
	"Major mode for editing Vala code"
	(kill-all-local-variables)
	(setq mode-name "vala" major-mode 'vala-mode)
	(setq-local comment-start "//")
	(set-syntax-table vala-mode-syntax-table)
	(setq-local font-lock-defaults '(vala-font-lock-keywords))
	(run-hooks 'vala-mode-hook)
)

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.vala\\'" . vala-mode))

(provide 'vala-mode)
