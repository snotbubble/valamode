;;; vala-mode.el

;; mode for Vala: https://vala.dev
;; by c.p.brown 2022~2023
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
		"null"
		"out"
		"string"
		"uint"
		"uint8"
		"void"
	)
)
(defconst vala-math-words '("sqrt" "min" "max" "abs" "floor"))
(defconst vala-io-words 
	'(
		"Dir" 
		"File" 
		"FileCreateFlags" 
		"FileOutputStream" 
		"FileStream" 
		"Path" 
		"Pid" 
		"SpawnError" 
		"SpawnFlags" 
		"append_to" 
		"build_filename" 
		"delete" 
		"get_current_dir" 
		"get_path" 
		"load_contents" 
		"make_directory_with_parents" 
		"message" 
		"new_for_path" 
		"open" 
		"query_exists" 
		"read_line" 
		"read_name" 
		"set_filename" 
		"spawn_sync" 
		"write" 
	)
)
(defconst vala-series-words '("length"))
(defconst vala-specialstring-words 
	'(
		"compress" 
		"concat" 
		"contains" 
		"data" 
		"escape" 
		"get_char" 
		"hash" 
		"replace" 
		"sizeof" 
		"split" 
		"strcmp" 
		"strip" 
		"substring" 
		"to_string" 
		"trim" 
	)
)
(defconst vala-system-words 
	'(
		"ApplicationFlags" 
		"Cairo" 
		"Environment" 
		"Error" 
		"EventControllerMotion" 
		"EventControllerScroll" 
		"EventControllerZoom" 
		"GLib" 
		"Gdk" 
		"GestureClick" 
		"GestureDrag" 
		"GestureZoom" 
		"Gtk" 
		"Math" 
		"Orientation" 
		"Pango" 
		"Process" 
		"RGBA" 
		"application" 
		"application_id" 
		"args" 
		"flags" 
		"get_default" 
		"init" 
		"main" 
		"main_quit" 
		"new" 
		"read_line" 
		"ref" 
		"run" 
		"spawn_async" 
		"using" 
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
		"add_titled" 
		"append" 
		"append_page" 
		"append_text" 
		"attach" 
		"bind_model" 
		"get_active" 
		"get_allocated_height" 
		"get_allocated_width" 
		"get_child" 
		"get_child_at_index" 
		"get_current_button" 
		"get_current_page" 
		"get_default_size" 
		"get_first_child" 
		"get_index" 
		"get_language" 
		"get_last_child" 
		"get_line_count"                     
		"get_next_sibling" 
		"get_orientation" 
		"get_row_at_index" 
		"get_scheme" 
		"get_selected" 
		"get_selected_row" 
		"get_size" 
		"get_start_child" 
		"get_string" 
		"get_style_context" 
		"get_value"
		"insert" 
		"insert_before" 
		"load_from_data" 
		"popdown" 
		"present" 
		"qsort_with_data" 
		"queue_draw" 
		"remove" 
		"reorder_child_after" 
		"reorder_child_before" 
		"set_active" 
		"set_baseline_row" 
		"set_button" 
		"set_child" 
		"set_column_spacing" 
		"set_default_size" 
		"set_draw_func" 
		"set_halign" 
		"set_hexpand" 
		"set_highlight_syntax" 
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
		"set_row_spacing" 
		"set_selected" 
		"set_selection_mode" 
		"set_sensitive"
		"set_show_border" 
		"set_shrink_end_child" 
		"set_size_request" 
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
		"HeaderBar" 
		"Label" 
		"LanguageManager" 
		"ListBox" 
		"MenuButton" 
		"Notebook" 
		"Object" 
		"Paned" 
		"Picture" 
		"Popover" 
		"Scale" 
		"ScrollDirection" 
		"ScrolledWindow" 
		"SpinButton" 
		"Stack" 
		"StackSwitcher" 
		"StackTransitionType" 
		"StringList" 
		"StringObject" 
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
		"value" 
		"vexpand" 
		"visible" 
		"wide_handle" 
		"width_request" 
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
		"BAD_WEEKDAY" 
		"BOLD" 
		"BOTTOM" 
		"BUTTON1_MOTION_MASK" 
		"BUTTON2_MOTION_MASK" 
		"BUTTON3_MOTION_MASK" 
		"BUTTON_PRESS_MASK" 
		"BUTTON_RELEASE_MASK" 
		"CAPTURE" 
		"DOWN" 
		"END" 
		"FLAGS_NONE" 
		"FRIDAY" 
		"HORIZONTAL" 
		"MONDAY" 
		"NORMAL" 
		"POINTER_MOTION_MASK" 
		"PRELIGHT" 
		"PRIVATE" 
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
		"event" 
		"motion" 
		"motion_notify" 
		"notify" 
		"pressed" 
		"released" 
		"scroll" 
		"selected" 
		"switch_page" 
		"toggled" 
		"touch" 
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
(defconst vala-modifier-words '("parse" "to_string"))

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
		(modify-syntax-entry ?{ "(}" table)
		(modify-syntax-entry ?} "){" table)
		;; string
		(modify-syntax-entry ?\" "\"" table)
		(modify-syntax-entry ?\\ "\\" table)
		;; words
		(modify-syntax-entry ?_ "w" table)
		;; not words
		(modify-syntax-entry ?, "." table)
		(modify-syntax-entry ?\; "." table)
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
