;;; vala-mode.el -*- coding: utf-8; lexical-binding: t; -*-

;; modified from sample in this article:
;; How to Write a Emacs Major Mode for Syntax Coloring By Xah Lee. 2008-11-30
;; http://www.ergoemacs.org/emacs/elisp_syntax_coloring.html

;; colors cycle down the list, from red to red, except for uservars
;;
;; #FF4D4D -control......... red
;; #E65C73 - specialstring
;; #CC5C81 - series
;; #CC5C95 - logic
;; #BF609F - modifiers
;; #A6624B - uservars....... brown (disabled for now; regex issues)
;; #9966CC - constants...... purple
;; #7F6CD9 - datatypes
;; #6C7ED9 - viewobj........ blue
;; #527BCC - viewcmd
;; #3992BF
;; #3EB2B3 - viewprop....... cyan
;; #3EB38C - context
;; #3EB365 - comment........ forest-green
;; #3FB33E
;; #599C36 - help........... green
;; #89B336 - datetime....... olive
;; #B3B22D - system
;; #BF8C26 - io............. yellow
;; #CC7B29 - events
;; #D9662B - comparison
;; #E64D2E - math

(defvar vala-system-word 'vala-system-word)
(defface vala-system-word '((t (:foreground "#B3B22D" :weight bold)))
	"system"
	:group 'vala-mode)

(defvar vala-io-word 'vala-io-word)
(defface vala-io-word '((t (:foreground "#BF8C26" :weight bold)))
	"io"
	:group 'vala-mode)

(defvar vala-events-word 'vala-events-word)
(defface vala-events-word '((t (:foreground "#CC7B29" :weight bold)))
	"events"
	:group 'vala-mode)

(defvar vala-comparison-word 'vala-comparison-word)
(defface vala-comparison-word '((t (:foreground "#D9662B" :weight bold)))
	"comparison"
	:group 'vala-mode)

(defvar vala-math-word 'vala-math-word)
(defface vala-math-word '((t (:foreground "#E64D2E" :weight bold)))
	"math"
	:group 'vala-mode)

(defvar vala-control-word 'vala-control-word)
(defface vala-control-word '((t (:foreground "#FF4D4D" :weight bold)))
	"control"
	:group 'vala-mode)

(defvar vala-specialstring-word 'vala-specialstring-word)
(defface vala-specialstring-word '((t (:foreground "#E65C73" :weight bold)))
	"specialstring"
	:group 'vala-mode)

(defvar vala-series-word 'vala-series-word)
(defface vala-series-word '((t (:foreground "#CC5C81" :weight bold)))
	"series"
	:group 'vala-mode)

(defvar vala-logic-word 'vala-logic-word)
(defface vala-logic-word '((t (:foreground "#CC5C95" :weight bold)))
	"logic"
	:group 'vala-mode)

(defvar vala-modifiers-word 'vala-modifiers-word)
(defface vala-modifiers-word '((t (:foreground "#BF609F" :weight bold)))
	"modifiers"
	:group 'vala-mode)

(defvar vala-var-word 'vala-var-word)
(defface vala-var-word '((t (:foreground "#B35147" :weight bold)))
	"user variables"
	:group 'vala-mode)

(defvar vala-constants-word 'vala-constants-word)
(defface vala-constants-word '((t (:foreground "#9966CC" :weight bold)))
	"constants"
	:group 'vala-mode)

(defvar vala-datatypes-word 'vala-datatypes-word)
(defface vala-datatypes-word '((t (:foreground "#7F6CD9" :weight bold)))
	"datatypes"
	:group 'vala-mode)

(defvar vala-viewobj-word 'vala-viewobj-word)
(defface vala-viewobj-word '((t (:foreground "#6C7ED9" :weight bold)))
	"viewobj"
	:group 'vala-mode)

(defvar vala-drawobj-word 'vala-drawobj-word)
(defface vala-drawobj-word '((t (:foreground "#6C7ED9" :weight bold)))
	"drawobj"
	:group 'vala-mode)

(defvar vala-viewcmd-word 'vala-viewcmd-word)
(defface vala-viewcmd-word '((t (:foreground "#527BCC" :weight bold)))
	"viewcmd"
	:group 'vala-mode)

(defvar vala-drawcmd-word 'vala-drawcmd-word)
(defface vala-drawcmd-word '((t (:foreground "#527BCC" :weight bold)))
	"drawcmd"
	:group 'vala-mode)

(defvar vala-viewprp-word 'vala-viewprp-word)
(defface vala-viewprp-word '((t (:foreground "#3EB2B3" :weight bold)))
	"viewprp"
	:group 'vala-mode)

(defvar vala-drawprp-word 'vala-drawprp-word)
(defface vala-drawprp-word '((t (:foreground "#3EB2B3" :weight bold)))
	"drawprp"
	:group 'vala-mode)

(defvar vala-context-word 'vala-context-word)
(defface vala-context-word '((t (:foreground "#3EB38C" :weight bold)))
	"context"
	:group 'vala-mode)

(defvar vala-comment-word 'vala-comment-word)
(defface vala-comment-word '((t (:foreground "#3EB365" :weight bold)))
	"modifiers"
	:group 'vala-mode)

(defvar vala-help-word 'vala-help-word)
(defface vala-help-word '((t (:foreground "#599C36" :weight bold)))
	"help"
	:group 'vala-mode)

(defvar vala-datetime-word 'vala-datetime-word)
(defface vala-datetime-word '((t (:foreground "#89B336" :weight bold)))
	"datetime"
	:group 'vala-mode)


;; override fonts, this is applies to all buffers, envestigate a local option
(set-face-foreground 'font-lock-string-face "#3EB365")
(set-face-foreground 'font-lock-comment-face "#4E736D")
(set-face-foreground 'default "#86B5BF")

;;
(modify-syntax-entry ?_ "w")

;; create the list for font-lock.
;; each category of keyword is given a particular face 
(
	setq vala-font-lock-keywords (
		let* (
			;; define several category of keywords
			(x-comparison '("not" "or" "xor" "compare"))
			(x-context '("public" "private" "context" "var" "construct"))
			(x-control '(
				"break" 
				"case" 
				"catch"
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
			))
			(x-help '("prin" "print" "printf"))
			(x-logic '("true" "false"))
			(x-datatypes '("bool" "int" "float" "string" "double" "uint" "void" "class" "null" "char" "out"))
			(x-math '("sqrt" "min" "max" "abs" "floor"))
			(x-io '(
				"append_to"
				"Dir"
				"File" 
				"FileCreateFlags"
				"FileOutputStream" 
				"FileStream" 
				"Path" 
				"build_filename" 
				"get_current_dir" 
				"get_path" 
				"load_contents"
				"make_directory_with_parents" 
				"message"
				"new_for_path" 
				"open"
				"Pid"
				"query_exists" 
				"read_line" 
				"read_name"
				"SpawnError"
				"SpawnFlags"
				"spawn_sync"
				"write" 
			))
			(x-series '("length"))
			(x-specialstring '(
				"concat" 
				"contains" 
				"replace"
				"sizeof" 
				"split" 
				"strcmp" 
				"strip"
				"substring"
				"trim" 
				"data"
				"to_string"
			))
			(x-system '(
				"ApplicationFlags"
				"Cairo" 
				"Environment" 
				"Error" 
				"EventControllerScroll"
				"EventControllerZoom"
				"EventControllerMotion"
				"GestureDrag"
				"GestureClick"
				"GestureZoom"
				"GLib" 
				"Gdk" 
				"Gtk" 
				"Math" 
				"Orientation"
				"Process.spawn_async" 
				"RGBA" 
				"application_id"
				"args" 
				"flags"
				"init" 
				"main"
				"main_quit" 
				"new" 
				"read_line" 
				"ref" 
				"using" 
			))
			(x-datetime '(
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
				"year" 
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
			))
			(x-viewcmd '(
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
				"get_next_sibling"
				"get_orientation"
				"get_row_at_index" 
				"get_selected"
				"get_selected_row" 
				"get_size"
				"get_start_child"
				"get_string"
				"get_style_context"
				"get_value"
				"insert" 
				"load_from_data" 
				"popdown" 
				"present" 
				"qsort_with_data"
				"queue_draw"
				"remove"
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
				"set_show_border" 
				"set_shrink_end_child"
				"set_size_request" 
				"set_stack"
				"set_style_scheme"
				"set_tab_pos" 
				"set_title_widget" 
				"set_titlebar" 
				"set_transition_type"
				"set_tooltip" 
				"set_value" 
				"set_vexpand" 
				"set_width_chars"
				"set_wrap_width"
				"show" 
				"show_all" 
				"show_close_button"
				"show_title_buttons" 
			))
			(x-viewobj '(
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
				"LanguageManager"
				"Label" 
				"ListBox" 
				"MenuButton" 
				"Notebook" 
				"Paned" 
				"Popover" 
				"Scale"
				"ScrollDirection" 
				"ScrolledWindow" 
				"space_drawer"
				"SpinButton" 
				"Stack"
				"StackSwitcher"
				"StringList"
				"StyleSchemeManager"
				"TabArray"
				"TextTagTable"
				"ToggleButton" 
				"ToolButton"
				"View" 
				"Window" 
			))
			(x-viewprp '(
				"accepts_tab"
				"active"
				"adjustment" 
				"alpha" 
				"border_width" 
				"bottom_margin"
				"buffer"
				"column_spacing"
				"enable_matrix"
				"end_child"
				"hexpand" 
				"highlight_current_line"
				"homogeneous" 
				"icon_name" 
				"indent_on_tab" 
				"indent_width" 
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
				"show_line_numbers"
				"spacing"
				"start_child" 
				"tab_width"
				"text" 
				"top_margin"
				"title" 
				"value" 
				"vexpand" 
				"visible" 
				"wide_handle" 
				"with_entry" 
				"with_label" 
				"with_range" 
				"with_value" 
				"wrap_width" 
				"xalign" 
			))
			(x-constants '(
				"BAD_WEEKDAY" 
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
			))
			(x-events '(
				"activate" 
				"activated" 
				"EventMask"
				"Gesture"
				"GestureMultiPress"
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
				"drag_update"
				"drag_end"
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
			))
			(x-drawcmd '(
				"close_path"
				"fill" 
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
			))
			(x-drawobj '("rectangle" "line" "arc"))
			(x-drawprp '("TextExtents" "text_extents" "width" "height" "LineCap"))
			(x-modifiers '("parse" "to_string"))
			;; generate regex string for each category of keywords
			;; suffixed words 1st, as they contain many duplicates
			(x-logic-regexp (regexp-opt x-logic 'words))
			;; hyphenated words, may contain duplicates
			(x-datatypes-regexp (regexp-opt x-datatypes 'words))
			(x-viewcmd-regexp (regexp-opt x-viewcmd 'words))
			(x-viewprp-regexp (regexp-opt x-viewprp 'words))
			(x-events-regexp (regexp-opt x-events 'words))
			;; special exception
			(x-comparison-regexp (regexp-opt x-comparison 'words))
			;; may contain the odd hyphen or suffix, but mostly pure
			(x-context-regexp (regexp-opt x-context 'words))
			(x-io-regexp (regexp-opt x-io 'words))
			(x-system-regexp (regexp-opt x-system 'words))
			(x-help-regexp (regexp-opt x-help 'words))
			(x-math-regexp (regexp-opt x-math 'words))
			(x-specialstring-regexp (regexp-opt x-specialstring 'words))
			(x-viewobj-regexp (regexp-opt x-viewobj 'words))
			(x-control-regexp (regexp-opt x-control 'words))
			;; 'pure' words; no hyphens, suffixes etc.
			(x-datetime-regexp (regexp-opt x-datetime 'words))
			(x-series-regexp (regexp-opt x-series 'words))
			(x-constants-regexp (regexp-opt x-constants 'words))
			(x-drawcmd-regexp (regexp-opt x-drawcmd 'words))
			(x-drawobj-regexp (regexp-opt x-drawobj 'words))
			(x-drawprp-regexp (regexp-opt x-drawprp 'words))
			(x-modifiers-regexp (regexp-opt x-modifiers 'words))
		)
		`(
			;; suffixed
			;;(,"[A-Za-z]+\\?+" . vala-logic-word)
			(,x-logic-regexp . vala-logic-word) 
			;; hyphenated
			(,x-datatypes-regexp . vala-datatypes-word)
			(,x-drawcmd-regexp . vala-drawcmd-word) 
			(,x-drawprp-regexp . vala-drawprp-word) 
			(,x-viewprp-regexp . vala-viewprp-word) 
			(,x-viewcmd-regexp . vala-viewcmd-word) 
			;; special exception
			(,x-comparison-regexp . vala-comparison-word)
			;; some suffixes or hyphens
			(,x-context-regexp . vala-context-word) 
			(,x-io-regexp . vala-io-word) 
			(,x-system-regexp . vala-system-word) 
			(,x-help-regexp . vala-help-word)
			(,x-math-regexp . vala-math-word) 
			(,x-specialstring-regexp . vala-specialstring-word) 
			(,x-datetime-regexp . vala-datetime-word) 
			(,x-viewobj-regexp . vala-viewobj-word) 
			(,x-control-regexp . vala-control-word)
			;; pure
			(,x-events-regexp . vala-events-word)
			(,x-series-regexp . vala-series-word) 
			(,x-constants-regexp . vala-constants-word) 
			(,x-drawobj-regexp . vala-drawobj-word)
			(,x-modifiers-regexp . vala-modifiers-word)
			;; note: order above matters, because once colored, that part won't change.
			;; in general, put longer words first
		)
	)
)

;;;###autoload
(
	define-derived-mode vala-mode c-mode "vala mode"
	"Major mode for editing Vala…"
	;; code for syntax highlighting
	(
		setq font-lock-defaults '(
			(
				vala-font-lock-keywords
			)
		)
	)
)

;; add the mode to the `features' list
(provide 'vala-mode)

;;; vala-mode.el ends here
