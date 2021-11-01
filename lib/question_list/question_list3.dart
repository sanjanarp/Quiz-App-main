const questionslist = [

    {'questionText':
        "Which one of the following is the deadlock avoidance algorithm? ",
      'answers': [{'text':'banker’s algorithm', 'score': true},
        {'text':'round-robin algorithm', 'score':false},
        {'text':'elevator algorithm', 'score':false},
        {'text':'karn’s algorithm', 'score':false}],
        'correctAns': 'banker’s algorithm',
        'explanation': 'User level threads are managed by thread library and the kernel is unaware of them.'
        },

    {'questionText': 'A problem encountered in multitasking when a process is perpetually denied necessary resources is called ____________',
      'answers': [{'text':'deadlock', 'score':false},
        {'text': 'starvation', 'score': true},
        {'text': 'inversion', 'score':false},
        {'text':'aging', 'score':false}],
        'correctAns': 'starvation',
        'explanation': 'User level threads are managed by thread library and the kernel is unaware of them.'
        },

    {'questionText': 'Which system call can be used by a parent process to determine the termination of child process? ',
      'answers': [{'text': 'fork', 'score': false},
        {'text': 'get' , 'score':false},
        {'text': 'exit', 'score':false},
        {'text': 'wait' , 'score':true}],
        'correctAns': 'wait',
        'explanation': 'User level threads are managed by thread library and the kernel is unaware of them.'
        },

];