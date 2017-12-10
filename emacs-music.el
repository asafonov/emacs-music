(defvar music-player-command "mpv --no-audio-display --loop --input-ipc-server=/tmp/mpvsocket ")
(defvar music-player-kill-command "echo 'quit' | socat - /tmp/mpvsocket")
(defvar music-toggle-command "echo 'cycle pause' | socat - /tmp/mpvsocket")
(defvar music-next-command "echo 'playlist-next' | socat - /tmp/mpvsocket")
(defvar music-prev-command "echo 'playlist-prev' | socat - /tmp/mpvsocket")

(defun music-url(filename)
  (interactive "sWhat to play?: ")
  (setq music-command (concat music-player-command filename))
  (message music-command)
  (call-process-shell-command music-command nil 0)
)
(defun music-file(filename)
  (interactive "fWhat to Play:")
  (setq filename (replace-regexp-in-string " " "\\\\ " filename))
  (setq filename (replace-regexp-in-string "(" "\\\\(" filename))
  (setq filename (replace-regexp-in-string ")" "\\\\)" filename))
  (music-url filename)
)
(defun music-dir(filename)
  (interactive "fWhat to Play:")
  (music-file (concat filename "/*"))
)
(defun nomusic()
  (interactive)
  (call-process-shell-command music-player-kill-command nil 0)
)
(defun gimmeradio()
  (interactive)
  (music-url "https://gimme-stream.s3-us-west-1.amazonaws.com/128k/gimme1_aac_128.m3u8")
)
(defun ultraradio()
  (interactive)
  (music-url "http://ultra128.streamr.ru")
)
(defun triplemradio()
  (interactive)
  (music-url "rtmp://wzvic.scahw.com.au/live/3mmm_128.stream")
)
(defun music-toggle()
  (interactive)
  (call-process-shell-command music-toggle-command nil 0)
)
(defun music-next()
  (interactive)
  (call-process-shell-command music-next-command nil 0)
)
(defun music-prev()
  (interactive)
  (call-process-shell-command music-prev-command nil 0)
)

(defun volume-up()
  (interactive)
  (shell-command "amixer -q sset Master 5%+")
)
(defun volume-down()
  (interactive)
  (shell-command "amixer -q sset Master 5%-")
)
(defun volume-set(num)
  (interactive "sVolume:")
  (shell-command (concat "amixer -q sset Master " num "%"))
)

(global-set-key (kbd "C-c +") 'volume-up)
(global-set-key (kbd "C-c -") 'volume-down)
(global-set-key (kbd "C-c !") 'music-toggle)
(global-set-key (kbd "C-c >") 'music-next)
(global-set-key (kbd "C-c q") 'nomusic)
(global-set-key (kbd "C-c <") 'music-prev)

(provide 'emacs-music)
