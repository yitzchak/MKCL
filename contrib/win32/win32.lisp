;;; Copyright (c) 2005, Michael Goffioul (michael dot goffioul at swing dot be)
;;; Copyright (c) 2012, Jean-Claude Beaudoin
;;;
;;;   This program is free software; you can redistribute it and/or
;;;   modify it under the terms of the GNU Library General Public
;;;   License as published by the Free Software Foundation; either
;;;   version 2 of the License, or (at your option) any later version.
;;;
;;;   See file '../../Copyright' for full details.
;;;
;;; FOREIGN FUNCTION INTERFACE TO MICROSOFT WINDOWS API
;;;
;;; This code as it currently stands is adequate for Win32
;;; but needs to be re-examined for Win64. 2012/12/24 JCB
;;;

(defpackage "WIN32"
  (:use "COMMON-LISP" "FFI")
  (:export))

(in-package "WIN32")

(clines
  "#include <windows.h>"
  "#include <commdlg.h>"  ;; because MKCL asks for WIN32_LEAN_AND_MEAN
  "#include <commctrl.h>"
  )

;; Windows types

(def-foreign-type HANDLE :pointer-void)
(def-foreign-type LPCSTR :cstring)
(def-foreign-type WNDPROC :pointer-void)
(def-foreign-type DWORD :unsigned-long)
(def-foreign-type WORD :unsigned-short)

(defmacro cstring (arg) `(convert-to-cstring ,arg)) ;; JCB

;; Windows constants

(defmacro define-win-constant (name value #|&optional (c-type :int)|#)
  `(defconstant ,name ,value))

(define-win-constant *TRUE* 1)
(define-win-constant *FALSE* 0)

(define-win-constant *WM_CLOSE*		#x0010)
(define-win-constant *WM_COMMAND*	#x0111)
(define-win-constant *WM_CONTEXTMENU*	#x007b)
(define-win-constant *WM_COPY*		#x0301)
(define-win-constant *WM_CREATE*	#x0001)
(define-win-constant *WM_CUT*		#x0300)
(define-win-constant *WM_DESTROY*	#x0002)
(define-win-constant *WM_GETFONT*	#x0031)
(define-win-constant *WM_GETMINMAXINFO*	#x0024)
(define-win-constant *WM_INITMENU*	#x0116)
(define-win-constant *WM_INITMENUPOPUP*	#x0117)
(define-win-constant *WM_NCPAINT*	#x0085)
(define-win-constant *WM_NOTIFY*	#x004e)
(define-win-constant *WM_PAINT*		#x000f)
(define-win-constant *WM_PASTE*		#x0302)
(define-win-constant *WM_QUIT*		#x0012)
(define-win-constant *WM_SETFOCUS*	#x0007)
(define-win-constant *WM_SETFONT*	#x0030)
(define-win-constant *WM_SIZE*		#x0005)
(define-win-constant *WM_UNDO*		#x0304)
(define-win-constant *WM_USER*		#x0400)

(define-win-constant *WS_BORDER*		#x00800000)
(define-win-constant *WS_CHILD*			#x40000000)
(define-win-constant *WS_CLIPCHILDREN*		#x02000000)
(define-win-constant *WS_CLIPSIBLINGS*		#x04000000)
(define-win-constant *WS_DLGFRAME*		#x00400000)
(define-win-constant *WS_DISABLED*		#x08000000)
(define-win-constant *WS_HSCROLL*		#x00100000)
(define-win-constant *WS_OVERLAPPEDWINDOW* 	#x00CF0000)
(define-win-constant *WS_VISIBLE*		#x10000000)
(define-win-constant *WS_VSCROLL*		#x00200000)

(define-win-constant *WS_EX_CLIENTEDGE*	#x00000200)

(define-win-constant *RICHEDIT_CLASS*	"RichEdit20A")
(define-win-constant *WC_LISTVIEW*	"SysListView32")
(define-win-constant *WC_TABCONTROL*	"SysTabControl32")

(define-win-constant *HWND_BOTTOM*	(make-pointer  1 'HANDLE))
(define-win-constant *HWND_NOTOPMOST*	(make-pointer  (- #-mingw64 #x100000000 #+mingw64 #x10000000000000000 2) 'HANDLE)) ;; JCB
(define-win-constant *HWND_TOP*		(make-pointer  0 'HANDLE))
(define-win-constant *HWND_TOPMOST*	(make-pointer  (- #-mingw64 #x100000000 #+mingw64 #x10000000000000000 1) 'HANDLE)) ;; JCB

(define-win-constant *SWP_DRAWFRAME*		#x0020)
(define-win-constant *SWP_HIDEWINDOW*		#x0080)
(define-win-constant *SWP_NOMOVE*		#x0002)
(define-win-constant *SWP_NOOWNERZORDER*	#x0200)
(define-win-constant *SWP_NOREDRAW*		#x0008)
(define-win-constant *SWP_NOREPOSITION*		#x0200)
(define-win-constant *SWP_NOSIZE*		#x0001)
(define-win-constant *SWP_NOZORDER*		#x0004)
(define-win-constant *SWP_SHOWWINDOW*		#x0040)

(define-win-constant *BS_DEFPUSHBUTTON*	#x00000000)
(define-win-constant *BS_PUSHBUTTON*	#x00000001)

(define-win-constant *BN_CLICKED*	0)

(define-win-constant *ES_AUTOHSCROLL*	#x0080)
(define-win-constant *ES_AUTOVSCROLL*	#x0040)
(define-win-constant *ES_LEFT*		#x0000)
(define-win-constant *ES_MULTILINE*	#x0004)

(define-win-constant *EM_CANUNDO*	#x00c6)
(define-win-constant *EM_SETEVENTMASK*	(+ *WM_USER* 69))
(define-win-constant *EM_SETSEL*	#x00b1)
(define-win-constant *EM_UNDO*		#x00c7)
(define-win-constant *EN_CHANGE*	#x0300)
(define-win-constant *ENM_CHANGE*	#x00000001)

(define-win-constant *TCIF_IMAGE*	#x0002)
(define-win-constant *TCIF_PARAM*	#x0008)
(define-win-constant *TCIF_RTLREADING*	#x0004)
(define-win-constant *TCIF_STATE*	#x0010)
(define-win-constant *TCIF_TEXT*	#x0001)

(define-win-constant *TCHT_NOWHERE*	#x0001)
(define-win-constant *TCHT_ONITEM*	#x0006)
(define-win-constant *TCHT_ONITEMICON*	#x0002)
(define-win-constant *TCHT_ONITEMLABEL*	#x0004)

(define-win-constant *TCM_FIRST*	#x1300)
(define-win-constant *TCN_FIRST*	#xfffffdda)
(define-win-constant *TCM_ADJUSTRECT*	(+ *TCM_FIRST* 40))
(define-win-constant *TCM_DELETEITEM*	(+ *TCM_FIRST* 8))
(define-win-constant *TCM_GETCURSEL*	(+ *TCM_FIRST* 11))
(define-win-constant *TCM_HITTEST*	(+ *TCM_FIRST* 13))
(define-win-constant *TCM_INSERTITEM*	(+ *TCM_FIRST* 7))
(define-win-constant *TCM_SETCURSEL*	(+ *TCM_FIRST* 12))
(define-win-constant *TCM_SETITEM*	(+ *TCM_FIRST* 6))
(define-win-constant *TCN_SELCHANGE*	(- *TCN_FIRST* 1))

(define-win-constant *NM_FIRST*		#x100000000)
(define-win-constant *NM_CLICK*		(- *NM_FIRST* 1))
(define-win-constant *NM_RCLICK*	(- *NM_FIRST* 5))

(define-win-constant *SW_HIDE*		0)
(define-win-constant *SW_SHOW*		5)
(define-win-constant *SW_SHOWNORMAL*	1)

(define-win-constant *RDW_ERASE*		#x0004)
(define-win-constant *RDW_FRAME*		#x0400)
(define-win-constant *RDW_INTERNALPAINT*	#x0002)
(define-win-constant *RDW_INVALIDATE*		#x0001)
(define-win-constant *RDW_NOERASE*		#x0020)
(define-win-constant *RDW_NOFRAME*		#x0800)
(define-win-constant *RDW_NOINTERNALPAINT*	#x0010)
(define-win-constant *RDW_VALIDATE*		#x0008)
(define-win-constant *RDW_ERASENOW*		#x0200)
(define-win-constant *RDW_UPDATENOW*		#x0100)
(define-win-constant *RDW_ALLCHILDREN*		#x0080)
(define-win-constant *RDW_NOCHILDREN*		#x0040)

(define-win-constant *CW_USEDEFAULT*	        #x-80000000)

(define-win-constant *IDC_ARROW*	(make-pointer 32512 :pointer-void))
(define-win-constant *IDI_APPLICATION*	(make-pointer 32512 :pointer-void))

(define-win-constant *COLOR_BACKGROUND*		1)
(define-win-constant *DEFAULT_GUI_FONT*		17)
(define-win-constant *OEM_FIXED_FONT*		10)
(define-win-constant *SYSTEM_FONT*		13)
(define-win-constant *SYSTEM_FIXED_FONT*	16)

(define-win-constant *MB_HELP*			#x00004000)
(define-win-constant *MB_OK*			#x00000000)
(define-win-constant *MB_OKCANCEL*		#x00000001)
(define-win-constant *MB_YESNO*			#x00000004)
(define-win-constant *MB_YESNOCANCEL*		#x00000003)
(define-win-constant *MB_ICONEXCLAMATION*	#x00000030)
(define-win-constant *MB_ICONWARNING*		#x00000020)
(define-win-constant *MB_ICONERROR*		#x00000010)
(define-win-constant *MB_ICONINFORMATION*	#x00000040)
(define-win-constant *MB_ICONQUESTION*		#x00000020)

(define-win-constant *IDCANCEL*	2)
(define-win-constant *IDNO*	7)
(define-win-constant *IDOK*	1)
(define-win-constant *IDYES*	6)

(define-win-constant *MF_BYCOMMAND*	#x00000000)
(define-win-constant *MF_BYPOSITION*	#x00000400)
(define-win-constant *MF_CHECKED*	#x00000008)
(define-win-constant *MF_DISABLED*	#x00000002)
(define-win-constant *MF_ENABLED*	#x00000000)
(define-win-constant *MF_GRAYED*	#x00000001)
(define-win-constant *MF_MENUBREAK*	#x00000040)
(define-win-constant *MF_POPUP*		#x00000010)
(define-win-constant *MF_SEPARATOR*	#x00000800)
(define-win-constant *MF_STRING* 	#x00000000)
(define-win-constant *MF_UNCHECKED*	#x00000000)

(define-win-constant *TPM_CENTERALIGN*	#x0004)
(define-win-constant *TPM_LEFTALIGN*	#x0000)
(define-win-constant *TPM_RIGHTALIGN*	#x0008)
(define-win-constant *TPM_BOTTOMALIGN*	#x0020)
(define-win-constant *TPM_TOPALIGN*	#x0000)
(define-win-constant *TPM_VCENTERALIGN*	#x0010)
(define-win-constant *TPM_NONOTIFY*	#x0080)
(define-win-constant *TPM_RETURNCMD*	#x0100)
(define-win-constant *TPM_LEFTBUTTON*	#x0000)
(define-win-constant *TPM_RIGHTBUTTON*	#x0002)

(define-win-constant *OFN_FILEMUSTEXIST*	#x00001000)
(define-win-constant *OFN_OVERWRITEPROMPT*	#x00000002)
(define-win-constant *OFN_PATHMUSTEXIST*	#x00000800)
(define-win-constant *OFN_READONLY*		#x00000001)

(define-win-constant *FVIRTKEY*		*TRUE*)
(define-win-constant *FNOINVERT*	#x02)
(define-win-constant *FSHIFT*		#x04)
(define-win-constant *FCONTROL*		#x08)
(define-win-constant *FALT*		#x10)

(define-win-constant *VK_F1*	#x70)
(define-win-constant *VK_LEFT*	#x25)
(define-win-constant *VK_RIGHT*	#x27)

(define-win-constant *GWL_EXSTYLE*	-20)
(define-win-constant *GWL_HINSTANCE*	-6)
(define-win-constant *GWL_HWNDPARENT*	-8)
(define-win-constant *GWL_ID*		-12)
(define-win-constant *GWL_STYLE*	-16)
(define-win-constant *GWL_WNDPROC*	-4)

(define-win-constant *FINDMSGSTRING* "commdlg_FindReplace")
(define-win-constant *HELPMSGSTRING* "commdlg_help")

(define-win-constant *FR_DIALOGTERM*	#x00000040)
(define-win-constant *FR_DOWN*		#x00000001)
(define-win-constant *FR_FINDNEXT* 	#x00000008)
(define-win-constant *FR_HIDEUPDOWN*	#x00004000)
(define-win-constant *FR_HIDEMATCHCASE*	#x00008000)
(define-win-constant *FR_HIDEWHOLEWORD*	#x00010000)
(define-win-constant *FR_MATCHCASE*	#x00000004)
(define-win-constant *FR_NOMATCHCASE*	#x00000800)
(define-win-constant *FR_NOUPDOWN*	#x00000400)
(define-win-constant *FR_NOWHOLEWORD*	#x00001000)
(define-win-constant *FR_REPLACE*	#x00000010)
(define-win-constant *FR_REPLACEALL*	#x00000020)
(define-win-constant *FR_SHOWHELP*	#x00000080)
(define-win-constant *FR_WHOLEWORD*	#x00000002)

(defconstant *NULL* (make-null-pointer :void))

;; Windows structures

(def-struct WNDCLASS
	    (style :unsigned-int)
	    (lpfnWndProc WNDPROC)
	    (cbClsExtra :int)
	    (cbWndExtra :int)
	    (hInstance HANDLE)
	    (hIcon HANDLE)
	    (hCursor HANDLE)
	    (hbrBackground HANDLE)
	    (lpszMenuName :cstring)
	    (lpszClassName :cstring))
(defun make-wndclass (name &key (style 0) (lpfnWndProc nil) (cbClsExtra 0) (cbWndExtra 0) (hInstance *NULL*)
			        (hIcon (default-icon)) (hCursor (default-cursor)) (hbrBackground (default-background))
				(lpszMenuName ""))
  (with-foreign-object (cls 'WNDCLASS)
    (setf (get-slot-value cls 'WNDCLASS 'style) style
	  (get-slot-value cls 'WNDCLASS 'lpfnWndProc) (callback 'wndproc-proxy)
	  (get-slot-value cls 'WNDCLASS 'cbClsExtra) cbClsExtra
	  (get-slot-value cls 'WNDCLASS 'cbWndExtra) cbWndExtra
	  (get-slot-value cls 'WNDCLASS 'hInstance) hInstance
	  (get-slot-value cls 'WNDCLASS 'hIcon) hIcon
	  (get-slot-value cls 'WNDCLASS 'hCursor) hCursor
	  (get-slot-value cls 'WNDCLASS 'hbrBackground) hbrBackground
	  (get-slot-value cls 'WNDCLASS 'lpszMenuName) lpszMenuName
	  (get-slot-value cls 'WNDCLASS 'lpszClassName) (string name))
    (register-wndproc (string name) lpfnWndProc)
    (registerclass cls)))

(def-struct POINT
	    (x :int)
	    (y :int))
(def-struct MSG
	    (hwnd HANDLE)
	    (message :unsigned-int)
	    (wParam :unsigned-int)
	    (lParam :int)
	    (time :unsigned-int)
	    (pt POINT))
(def-struct CREATESTRUCT
	    (lpCreateParams :pointer-void)
	    (hInstance HANDLE)
	    (hMenu HANDLE)
	    (hwndParent HANDLE)
	    (cx :int)
	    (cy :int)
	    (x :int)
	    (y :int)
	    (style :long)
	    (lpszName :cstring)
	    (lpszClass :cstring)
	    (dwExStyle :unsigned-int))
(def-struct MINMAXINFO
	    (ptReserved POINT)
	    (ptMaxSize POINT)
	    (ptMaxPosition POINT)
	    (ptMinTrackSize POINT)
	    (ptMaxTrackSize POINT))
(def-struct TEXTMETRIC (tmHeight :long) (tmAscent :long) (tmDescent :long) (tmInternalLeading :long) (tmExternalLeading :long)
	               (tmAveCharWidth :long) (tmMaxCharWidth :long) (tmWeight :long) (tmOverhang :long) (tmDigitizedAspectX :long)
		       (tmDigitizedAspectY :long) (tmFirstChar :char) (tmLastChar :char) (tmDefaultChar :char) (tmBreakChar :char)
		       (tmItalic :byte) (tmUnderlined :byte) (tmStruckOut :byte) (tmPitchAndFamily :byte) (tmCharSet :byte))
(def-struct SIZE (cx :long) (cy :long))
(def-struct RECT (left :long) (top :long) (right :long) (bottom :long))
(def-struct TITLEBARINFO (cbSize :unsigned-int) (rcTitlebar RECT) (rgstate (:array :unsigned-int 6)))
(def-struct OPENFILENAME
  (lStructSize :unsigned-int) (hwndOwner HANDLE)
  (hInstance HANDLE) (lpstrFilter LPCSTR) (lpstrCustomFilter LPCSTR)
  (nMaxFilter :unsigned-int) (nFilterIndex :unsigned-int)
  (lpstrFile LPCSTR) (nMaxFile :unsigned-int) (lpstrFileTitle LPCSTR)
  (nMaxFileTitle :unsigned-int) (lpstrInitialDir LPCSTR) (lpstrTitle LPCSTR)
  (Flags :unsigned-int) (nFileOffset :unsigned-short)
  (nFileExtension :unsigned-short) (lpstrDefExt LPCSTR) (lCustData :int)
  (lpfnHook HANDLE) (lpTemplateName LPCSTR)
  #|(pvReserved :pointer-void) (dwReserved :unsigned-int) (FlagsEx :unsigned-int)|#)
(def-struct ACCEL (fVirt :byte) (key :unsigned-short) (cmd :unsigned-short))
(def-struct TCITEM (mask :unsigned-int) (dwState :unsigned-int) (dwStateMask :unsigned-int)
	           (pszText :cstring) (cchTextMax :int) (iImage :int) (lParam :long))
(def-struct NMHDR (hwndFrom HANDLE) (idFrom :unsigned-int) (code :unsigned-int))
(def-struct TCHITTESTINFO (pt POINT) (flag :unsigned-int))
(def-struct TPMPARAMS (cbSize :unsigned-int) (rcExclude RECT))
(def-struct FINDREPLACE (lStructSize DWORD) (hwndOwner HANDLE) (hInstance HANDLE) (Flags DWORD)
	    		(lpstrFindWhat LPCSTR) (lpstrReplaceWith LPCSTR) (wFindWhatLen WORD) (wReplaceWithLen WORD)
			(lpCustData :int) (lpfnHook HANDLE) (lpTemplateName LPCSTR))

;; Windows functions

(defvar *wndproc-db* nil)
(defun register-wndproc (class-or-obj wndproc)
  (let ((entry (assoc class-or-obj *wndproc-db* :test #'equal)))
    (if entry
      (rplacd entry wndproc)
      (push (cons class-or-obj wndproc) *wndproc-db*)))
  (unless (stringp class-or-obj)
#|
    (let ((old-proc (make-pointer (getwindowlong class-or-obj *GWL_WNDPROC*) 'HANDLE)))
      (setwindowlong class-or-obj *GWL_WNDPROC* (make-lparam (callback 'wndproc-proxy)))
      old-proc)
|#
    (let ((old-proc (make-pointer (pointer-address (getwindowlongptr class-or-obj *GWL_WNDPROC*)) 'HANDLE))) ;; JCB
      (setwindowlongptr class-or-obj *GWL_WNDPROC* (callback 'wndproc-proxy))
      old-proc)))
(defun get-wndproc (obj)
  (let ((entry (or (assoc obj *wndproc-db* :test #'equal)
		   (assoc (getclassname obj) *wndproc-db* :test #'equal))))
    (and entry
	 (cdr entry))))
(defcallback (wndproc-proxy :stdcall) :int ((hnd :pointer-void) (umsg :unsigned-int) (wparam :unsigned-int) (lparam :int))
  (let* ((wndproc (get-wndproc hnd)))
    ;;(format t "~&In wndproc-proxy: umsg = ~S.~%" umsg) (finish-output)
    (unless wndproc
      (error "Cannot find a registered Windows prodecure for object ~S" hnd))
    (funcall wndproc hnd umsg wparam lparam)))

(defun make-ID (id) (make-pointer id :pointer-void))
(setf (symbol-function 'make-handle) #'make-ID)
(defun make-wparam (hnd) (pointer-address hnd))
(defun make-lparam (hnd) (pointer-address hnd))
(defmacro with-cast-int-pointer ((var type &optional ptr) &body body)
  (unless ptr (setq ptr var))
  `(let ((,var (make-pointer ,ptr ',type))) ,@body))

(defmacro def-win32-function (name args &key (returning :void) module)
  `(def-function ,name ,args :returning ,returning :module ,module :call :stdcall))
(eval-when (:compile-toplevel)
  (define-compiler-macro def-win32-function (name args &key (returning :void) module)
    `(def-function ,name ,args :returning ,returning)))
(load-foreign-library "kernel32")
(load-foreign-library "comdlg32")
(load-foreign-library "gdi32")
(load-foreign-library "comctl32")

(def-win32-function ("RtlZeroMemory" zeromemory) ((Destination :pointer-void) (Length :unsigned-int)) :returning :void :module "kernel32")
(def-win32-function ("LoadLibraryA" loadlibrary) ((lpLibFileName LPCSTR)) :returning HANDLE :module "kernel32")
(def-win32-function ("FreeLibrary" freelibrary) ((hLibModule HANDLE)) :returning :int :module "kernel32")
(def-win32-function ("GetModuleHandleA" getmodulehandle) ((lpModuleName LPCSTR)) :returning HANDLE :module "kernel32")
(def-win32-function ("GetStockObject" getstockobject) ((fnObject :int)) :returning HANDLE :module "gdi32")
(def-win32-function ("GetTextMetricsA" gettextmetrics) ((hdc HANDLE) (lptm (* TEXTMETRIC))) :returning :int :module "gdi32")
(def-win32-function ("GetDC" getdc) ((hWnd HANDLE)) :returning HANDLE :module "user32")
(def-win32-function ("ReleaseDC" releasedc) ((hWnd HANDLE) (hdc HANDLE)) :returning :int :module "user32")
(def-win32-function ("SelectObject" selectobject) ((hdc HANDLE) (hgdiobj HANDLE)) :returning HANDLE :module "gdi32")
(def-win32-function ("GetTextExtentPoint32A" gettextextentpoint32) ((hdc HANDLE) (lpString :cstring) (cbString :int) (lpSize (* SIZE))) :returning :int :module "gdi32")
(def-win32-function ("LoadCursorA" loadcursor-string) ((hnd HANDLE) (lpCursorName LPCSTR)) :returning HANDLE :module "user32")
(def-win32-function ("LoadCursorA" loadcursor-raw) ((hnd HANDLE) (lpCursorName :pointer-void)) :returning HANDLE :module "user32")
(defun loadcursor (hnd cur-name)
  (etypecase cur-name
    (foreign (loadcursor-raw hnd cur-name))
    (string (loadcursor-string hnd cur-name))))
(defun default-cursor () (loadcursor *NULL* *IDC_ARROW*))
(def-win32-function ("LoadIconA" loadicon-raw) ((hnd HANDLE) (lpIconName :pointer-void)) :returning HANDLE :module "user32")
(def-win32-function ("LoadIconA" loadicon-string) ((hnd HANDLE) (lpIconName LPCSTR)) :returning HANDLE :module "user32")
(defun loadicon (hnd cur-name)
  (etypecase cur-name
    (foreign (loadicon-raw hnd cur-name))
    (string (loadicon-string hnd cur-name))))
(defun default-icon () (loadicon *NULL* *IDI_APPLICATION*))
(defun default-background () (getstockobject *COLOR_BACKGROUND*))
(def-win32-function ("GetLastError" getlasterror) () :returning :unsigned-int :module "kernel32")
(def-win32-function ("GetClassNameA" getclassname-i) ((hnd HANDLE) (lpClassName (* :char)) (maxCount :int)) :returning :int :module "user32")
(defun getclassname (hnd &aux (max-length 64))
  (with-foreign-object (s `(:array :char ,max-length))
    (let ((n (getclassname-i hnd s max-length)))
      (when (= n 0)
	(error "Unable to get class name for ~A" hnd))
      (convert-from-foreign-string s :length n))))
(def-win32-function ("RegisterClassA" registerclass) ((lpWndClass (* WNDCLASS))) :returning :int :module "user32")
(def-win32-function ("UnregisterClassA" unregisterclass) ((lpClassName :cstring) (hInstance HANDLE)) :returning :int :module "user32")

(def-win32-function ("GetWindowLongA" getwindowlong) ((hWnd HANDLE) (nIndex :int)) :returning :long :module "user32")
(def-win32-function ("SetWindowLongA" setwindowlong) ((hWnd HANDLE) (nIndex :int) (dwNewLong :long)) :returning :long :module "user32")
#-mingw64 ;; JCB
;;(def-win32-function ("GetWindowLongA" getwindowlongptr) ((hWnd HANDLE) (nIndex :int)) :returning :pointer-void :module "user32")
(defun getwindowlongptr (hWnd nIndex) (make-pointer (ldb (byte 32 0) (getwindowlong hWnd nIndex)) :pointer-void))
#-mingw64 ;; JCB
;;(def-win32-function ("SetWindowLongA" setwindowlongptr) ((hWnd HANDLE) (nIndex :int) (dwNewLong :pointer-void)) :returning :pointer-void :module "user32")
(defun setwindowlongptr (hWnd nIndex dwNewLong)
  (make-pointer (ldb (byte 32 0) (setwindowlong hWnd nIndex (ldb (byte 32 0) (- (pointer-address dwNewLong) #x100000000)))) :pointer-void))

#+mingw64 ;; JCB
(def-win32-function ("GetWindowLongPtrA" getwindowlongptr) ((hWnd HANDLE) (nIndex :int)) :returning :pointer-void :module "user32")
#+mingw64 ;; JCB
(def-win32-function ("SetWindowLongPtrA" setwindowlongptr) ((hWnd HANDLE) (nIndex :int) (dwNewLong :pointer-void)) :returning :pointer-void :module "user32")
(def-win32-function ("CreateWindowExA" createwindowex) ((dwExStyle :unsigned-int) (lpClassName :cstring)
							(lpWindowName :cstring) (dwStyle :unsigned-int)
							(x :int) (y :int) (nWidth :int) (nHeight :int)
							(hWndParent HANDLE) (hMenu HANDLE) (hInstance HANDLE)
							(lpParam :pointer-void))
	      				        :returning HANDLE :module "user32")
(defun createwindow (&rest args)
  (apply #'createwindowex 0 args))
(def-win32-function ("DestroyWindow" destroywindow) ((hWnd HANDLE)) :returning :int :module "user32")
(def-win32-function ("ShowWindow" showwindow) ((hWnd HANDLE) (nCmdShow :int)) :returning :int :module "user32")
(def-win32-function ("UpdateWindow" updatewindow) ((hWnd HANDLE)) :returning :void :module "user32")
(def-win32-function ("RedrawWindow" redrawwindow) ((hWnd HANDLE) (lprcUpdate (* RECT)) (hrgnUpdate HANDLE) (flags :unsigned-int)) :returning :int :module "user32")
(def-win32-function ("MoveWindow" movewindow) ((hWnd HANDLE) (x :int) (y :int) (nWidth :int) (nHeight :int) (bRepaint :int)) :returning :int :module "user32")
(def-win32-function ("SetWindowPos" setwindowpos) ((hWnd HANDLE) (hWndInsertAfter HANDLE) (x :int)
					     (y :int) (cx :int) (cy :int) (uFlags :unsigned-int)) :returning :int :module "user32")
(def-win32-function ("BringWindowToTop" bringwindowtotop) ((hWnd HANDLE)) :returning :int :module "user32")
(def-win32-function ("GetWindowTextA" getwindowtext-i) ((hWnd HANDLE) (lpString LPCSTR) (nMaxCount :int)) :returning :int :module "user32")
(defun getwindowtext (hnd)
  (let ((len (1+ (getwindowtextlength hnd))))
    (with-cstring (s (make-string len))
      (getwindowtext-i hnd s len)
      (subseq s 0 (1- len)))))
(def-win32-function ("GetWindowTextLengthA" getwindowtextlength) ((hWnd HANDLE)) :returning :int :module "user32")
(def-win32-function ("SetWindowTextA" setwindowtext) ((hWnd HANDLE) (lpString LPCSTR)) :returning :int :module "user32")
(def-win32-function ("GetParent" getparent) ((hWnd HANDLE)) :returning HANDLE :module "user32")
(def-win32-function ("GetClientRect" getclientrect) ((hWnd HANDLE) (lpRect (* RECT))) :returning :int :module "user32")
(def-win32-function ("GetWindowRect" getwindowrect) ((hWnd HANDLE) (lpRect (* RECT))) :returning :int :module "user32")
(def-win32-function ("InvalidateRect" invalidaterect) ((hWnd HANDLE) (lpRect (* RECT)) (bErase :int)) :returning :int :module "user32")
(def-win32-function ("SetRect" setrect) ((lpRect (* RECT)) (xLeft :int) (yTop :int) (xRight :int) (yBottom :int)) :returning :int :module "user32")
;(def-win32-function ("GetTitleBarInfo" gettitlebarinfo) ((hWnd HANDLE) (pti (* TITLEBARINFO))) :returning :int)
(def-win32-function ("SetFocus" setfocus) ((hWnd HANDLE)) :returning HANDLE :module "user32")
(def-win32-function ("PostQuitMessage" postquitmessage) ((nExitCode :int)) :returning :void :module "user32")
(def-win32-function ("SendMessageA" sendmessage) ((hWnd HANDLE) (uMsg :unsigned-int) (wParam :unsigned-int) (lParam :int)) :returning :int :module "user32")
(def-win32-function ("PostMessageA" postmessage) ((hWnd HANDLE) (uMsg :unsigned-int) (wParam :unsigned-int) (lParam :int)) :returning :int :module "user32")
(def-win32-function ("RegisterWindowMessageA" registerwindowmessage) ((lpString LPCSTR)) :returning :unsigned-int :module "user32")
(def-win32-function ("IsDialogMessageA" isdialogmessage) ((hDlg HANDLE) (lpMsg (* MSG))) :returning :int :module "user32")
(def-win32-function ("DefWindowProcA" defwindowproc) ((hWnd HANDLE) (uMsg :unsigned-int) (wParam :unsigned-int) (lParam :int)) :returning :int :module "user32")
(def-win32-function ("CallWindowProcA" callwindowproc) ((wndProc HANDLE) (hWnd HANDLE) (uMsg :unsigned-int) (wParam :unsigned-int) (lParam :int)) :returning :int :module "user32")
(defun loword (x) (logand x #xffff))
(defun hiword (x) (logand (floor x 65536) #xffff))
(defun get-x-lparam (x) (loword x))
(defun get-y-lparam (x) (hiword x))
(def-win32-function ("ScreenToClient" screentoclient) ((hWnd HANDLE) (pt (* POINT))) :returning :int :module "user32")
(def-win32-function ("MessageBoxA" messagebox) ((hWnd HANDLE) (lpText LPCSTR) (lpCaption LPCSTR) (uType :unsigned-int)) :returning :int :module "user32")
(def-win32-function ("GetOpenFileNameA" getopenfilename) ((lpofn (* OPENFILENAME))) :returning :int :module "comdlg32")
(def-win32-function ("GetSaveFileNameA" getsavefilename) ((lpofn (* OPENFILENAME))) :returning :int :module "comdlg32")
(def-win32-function ("FindTextA" findtext) ((lpfr (* FINDREPLACE))) :returning HANDLE :module "comdlg32")
(def-win32-function ("ReplaceTextA" replacetext) ((lpfr (* FINDREPLACE))) :returning HANDLE :module "comdlg32")
(def-win32-function ("GetMessageA" getmessage) ((lpMsg (* MSG)) (hWnd HANDLE) (wMsgFitlerMin :unsigned-int) (wMsgFilterMax :unsigned-int)) :returning :int :module "user32")
(def-win32-function ("TranslateMessage" translatemessage) ((lpMsg (* MSG))) :returning :int :module "user32")
(def-win32-function ("DispatchMessageA" dispatchmessage) ((lpMsg (* MSG))) :returning :int :module "user32")
(def-win32-function ("CreateMenu" createmenu) nil :returning HANDLE :module "user32")
(def-win32-function ("CreatePopupMenu" createpopupmenu) nil :returning HANDLE :module "user32")
(def-win32-function ("DestroyMenu" destroymenu) ((hMenu HANDLE)) :returning :int :module "user32")
(def-win32-function ("AppendMenuA" appendmenu) ((hMenu HANDLE) (uFlags :unsigned-int) (uIDNewItem :unsigned-int) (lpNewItem LPCSTR)) :returning :int :module "user32")
(def-win32-function ("GetSubMenu" getsubmenu) ((hMenu HANDLE) (nPos :int)) :returning HANDLE :module "user32")
(def-win32-function ("DeleteMenu" deletemenu) ((hMenu HANDLE) (uPosition :unsigned-int) (uFlags :unsigned-int)) :returning :int :module "user32")
(def-win32-function ("RemoveMenu" removemenu) ((hMenu HANDLE) (uPosition :unsigned-int) (uFlags :unsigned-int)) :returning :int :module "user32")
(def-win32-function ("GetMenuItemCount" getmenuitemcount) ((hMenu HANDLE)) :returning :int :module "user32")
(def-win32-function ("CheckMenuItem" checkmenuitem) ((hMenu HANDLE) (uIDCheckItem :unsigned-int) (uCheck :unsigned-int)) :returning :int :module "user32")
(def-win32-function ("EnableMenuItem" enablemenuitem) ((hMenu HANDLE) (uIDCheckItem :unsigned-int) (uCheck :unsigned-int)) :returning :int :module "user32")
(def-win32-function ("TrackPopupMenu" trackpopupmenu) ((hMenu HANDLE) (uFlags :unsigned-int) (x :int) (y :int)
						 (nReserved :int) (hWnd HANDLE) (prcRect HANDLE)) :returning :int :module "user32")
(def-win32-function ("TrackPopupMenuEx" trackpopupmenuex) ((hMenu HANDLE) (fuFlags :unsigned-int) (x :int) (y :int)
						     (hWnd HANDLE) (lptpl (* TPMPARAMS))) :returning :int :module "user32")
(def-win32-function ("CreateAcceleratorTableA" createacceleratortable) ((lpaccl (* ACCEL)) (cEntries :int)) :returning HANDLE :module "user32")
(def-win32-function ("TranslateAcceleratorA" translateaccelerator) ((hWnd HANDLE) (hAccTable HANDLE) (lpMsg (* MSG))) :returning :int :module "user32")
(def-win32-function ("DestroyAcceleratorTable" destroyacceleratortable) ((hAccTable HANDLE)) :returning :int :module "user32")
(def-win32-function ("InitCommonControls" initcommoncontrols) () :returning :void :module "comctl32")

(defun event-loop (&key (accelTable *NULL*) (accelMain *NULL*) (dlgSym nil))
  (with-foreign-object (msg 'MSG)
    (loop for bRet = (getmessage msg *NULL* 0 0)
	  when (= bRet 0) return bRet
	  if (= bRet -1)
	        do (error "GetMessage failed!!!")
	  else
	    do (or (and (not (null-pointer-p accelTable))
			(not (null-pointer-p accelMain))
			(/= (translateaccelerator accelMain accelTable msg) 0))
		   (and dlgSym
			(not (null-pointer-p (symbol-value dlgSym)))
			(/= (isdialogmessage (symbol-value dlgSym) msg) 0))
		   (progn
		     (translatemessage msg)
		     (dispatchmessage msg))))))

(defun y-or-no-p (&optional control &rest args)
  (let ((s (coerce (apply #'format nil control args) 'simple-base-string))) ;; JCB 
    (= (messagebox *NULL* s "MKCL Dialog" (logior *MB_YESNO* *MB_ICONQUESTION*))
       *IDYES*)))

(defun get-open-filename (&key (owner *NULL*) initial-dir filter (dlgfn #'getopenfilename) 
			       (flags 0) &aux (max-fn-size 1024))
  (declare (ignore initial-dir))
  (flet ((null-concat (x &optional y &aux (xx (if y x (car x))) (yy (if y y (cdr x))))
	   (concatenate 'string xx (string #\Null) yy)))
    (when filter
      (setq filter (format nil "~A~C~C" (reduce #'null-concat (mapcar #'null-concat filter)) #\Null #\Null)))
    (with-foreign-object (ofn 'OPENFILENAME)
      (with-cstrings ((fn (make-string  max-fn-size :initial-element #\Null))
		      (filter filter))
        (zeromemory ofn (size-of-foreign-type 'OPENFILENAME))
	(setf (get-slot-value ofn 'OPENFILENAME 'lStructSize) (size-of-foreign-type 'OPENFILENAME))
	(setf (get-slot-value ofn 'OPENFILENAME 'hwndOwner) owner)
	(setf (get-slot-value ofn 'OPENFILENAME 'lpstrFile) fn)
	(setf (get-slot-value ofn 'OPENFILENAME 'nMaxFile) max-fn-size)
	(setf (get-slot-value ofn 'OPENFILENAME 'Flags) flags)
	(when filter
	  (setf (get-slot-value ofn 'OPENFILENAME 'lpstrFilter) filter))
	(unless (= (funcall dlgfn ofn) 0)
	  (pathname (string-trim (string #\Null) fn)))))))

(defun find-text (&key (owner *NULL*) &aux (max-txt-size 1024))
  (with-foreign-object (fr 'FINDREPLACE)
    (with-cstring (txt (make-string max-txt-size :initial-element #\Null))
      (zeromemory fr (size-of-foreign-type 'FINDREPLACE))
      (setf (get-slot-value fr 'FINDREPLACE 'lStructSize) (size-of-foreign-type 'FINDREPLACE))
      (setf (get-slot-value fr 'FINDREPLACE 'hwndOwner) owner)
      (setf (get-slot-value fr 'FINDREPLACE 'wFindWhatLen) max-txt-size)
      ;(setf (get-slot-value fr 'FINDREPLACE 'Flags) 1)
      (let ((result (findtext fr)))
	(print result)
	txt))))

#|
(defun set-wndproc (obj fun)
  (let ((cb (si:make-dynamic-callback fun (read-from-string (format nil "~A-WNDPROC" (gensym))) :int '(:pointer-void :unsigned-int :unsigned-int :int)))
	(old-wndproc (make-pointer (getwindowlong obj *GWL_WNDPROC*) 'HANDLE)))
    (setwindowlong obj *GWL_WNDPROC* (make-lparam cb))
    old-wndproc))
|#

(provide "WIN32")

;;; Test code

(defconstant *HELLO_ID* 100)
(defconstant *OK_ID* 101)

(defparameter hBtn nil)
(defparameter hOk nil)

(defun button-min-size (hnd)
  (let ((fnt (make-pointer (sendmessage hnd *WM_GETFONT* 0 0) :pointer-void))
	(hdc (getdc hnd))
	(txt (getwindowtext hnd)))
    (unless (null-pointer-p fnt)
      (selectobject hdc fnt))
    (with-foreign-objects ((sz 'SIZE)
			   (tm 'TEXTMETRIC))
      (gettextextentpoint32 hdc txt (length txt) sz)
      (gettextmetrics hdc tm)
      (releasedc hnd hdc)
      (list (+ (get-slot-value sz 'SIZE 'cx) 20)
	    (+ (get-slot-value tm 'TEXTMETRIC 'tmHeight) 10)))))

(defun get-titlebar-rect (hnd)
  (with-foreign-object (ti 'TITLEBARINFO)
    (setf (get-slot-value ti 'TITLEBARINFO 'cbSize) (size-of-foreign-type 'TITLEBARINFO))
    (gettitlebarinfo hnd ti)
    (let ((rc (get-slot-value ti 'TITLEBARINFO 'rcTitlebar)))
      (list (get-slot-value rc 'RECT 'left)
	    (get-slot-value rc 'RECT 'top)
	    (get-slot-value rc 'RECT 'right)
	    (get-slot-value rc 'RECT 'bottom)))))

(defun test-wndproc (hwnd umsg wparam lparam)
  (cond ((= umsg *WM_DESTROY*)
	 (setq hBtn nil hOk nil)
	 (postquitmessage 0)
	 0)
	((= umsg *WM_CREATE*)
	 (setq hBtn (createwindowex 0  "BUTTON" "Hello World!" (logior *WS_VISIBLE* *WS_CHILD* *BS_PUSHBUTTON*)
				  0 0 50 20 hwnd (make-ID *HELLO_ID*) *NULL* *NULL*))
	 (setq hOk (createwindowex 0  "BUTTON" "Close" (logior *WS_VISIBLE* *WS_CHILD* *BS_PUSHBUTTON*)
				 0 0 50 20 hwnd (make-ID *OK_ID*) *NULL* *NULL*))
	 (sendmessage hBtn *WM_SETFONT* (make-wparam (getstockobject *DEFAULT_GUI_FONT*)) 0)
	 (sendmessage hOk *WM_SETFONT* (make-wparam (getstockobject *DEFAULT_GUI_FONT*)) 0)
	 0)
	((= umsg *WM_SIZE*)
	 (let* ((new-w (loword lparam))
		(new-h (hiword lparam))
		(wb (- new-w 20))
		(hb (floor (/ (- new-h 30) 2))))
	   (movewindow hBtn 10 10 wb hb *TRUE*)
	   (movewindow hOk 10 (+ 20 hb) wb hb *TRUE*))
	 0)
	((= umsg *WM_GETMINMAXINFO*)
	 (let* ((btn1-sz (and hBtn (button-min-size hBtn)))
	        (btn2-sz (and hOk (button-min-size hOk)))
	        #|(rc (get-titlebar-rect hWnd))|#
		(titleH #|(1+ (- (fourth rc) (second rc)))|# 30))
	   (when (and btn1-sz btn2-sz (> titleH 0))
	     (with-foreign-object (minSz 'POINT)
	       (setf (get-slot-value minSz 'POINT 'x) (+ (max (first btn1-sz) (first btn2-sz)) 20))
	       (setf (get-slot-value minSz 'POINT 'y) (+ (second btn1-sz) (second btn2-sz) 30 titleH))
	       (with-cast-int-pointer (lparam MINMAXINFO)
		 (setf (get-slot-value lparam 'MINMAXINFO 'ptMinTrackSize) minSz)))))
	 0)
	((= umsg *WM_COMMAND*)
	 (let ((n (hiword wparam))
	       (id (loword wparam)))
	   (cond ((= n *BN_CLICKED*)
		  (cond ((= id *HELLO_ID*)
			 (format t "~&Hellow World!~%")
			 (get-open-filename :owner hwnd))
			((= id *OK_ID*)
			 (destroywindow hwnd))))
		 (t
		  (format t "~&Un-handled notification: ~D~%" n))))
	 0)
	(t
	 (defwindowproc hwnd umsg wparam lparam))))

(defun do-test ()
  (make-wndclass "MyClass"
    :lpfnWndProc #'test-wndproc)
  (let* ((hwnd (createwindowex
		0
	        "MyClass"
	        "MKCL/Win32 test"
	        *WS_OVERLAPPEDWINDOW*
	        *CW_USEDEFAULT*
	        *CW_USEDEFAULT*
		130
		120
	        *NULL*
	        *NULL*
		*NULL*
	        *NULL*)))
    (when (si::null-pointer-p hwnd)
      (error "Unable to create window"))
    (showwindow hwnd *SW_SHOWNORMAL*)
    (updatewindow hwnd)
    (event-loop)
    (unregisterclass "MyClass" *NULL*)))

