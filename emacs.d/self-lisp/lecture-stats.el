;; Compute the statistics on lecture videos

(defun self/avg-pomodors-per-lecture (pomodoros current-lecture)
  "Average number of pomodoros per lecture"
  (message "Pomodoros %d Lectures %d" pomodoros current-lecture)
  (if (<= current-lecture 1)
      0
    (let ((completed (1- current-lecture)))
      (/ (float pomodoros) completed))))

(defun self/lecture-velocity (current-lecture weeks)
  "Compute the average number of lectures completed per week"
  (if (= weeks 0)
      0
    ;; current lecture is still in progress.
    ;; leave that from the computation
    (let ((completed (1- current-lecture)))
      (/ (float completed) weeks))))

(defun self/pomodoro-velocity (pomodoros weeks)
  "Compute the average number of pomodoros completed per week"
  (if (= weeks 0)
      0
    (/ (float pomodoros) weeks)))

(defun self/weeks-required-by-lecture (total-lectures current-lecture weeks)
  "Find the number of more weeks required, based on the lecture data"
  (if (= weeks 0)
      0
    (let* ((completed (1- current-lecture))
           (pending (- total-lectures completed))
           (velocity (self/lecture-velocity current-lecture weeks)))
      (/ (float pending) velocity))))

(defun self/weeks-required-by-pomodoro (total current weeks)
  "Find the number of weeks required, based on the pomodoro data"
  (if (= weeks 0)
      0
    (let* ((completed current)
           (pending (- total completed))
           (velocity (self/pomodoro-velocity completed weeks)))
      (/ (float pending) velocity))))
