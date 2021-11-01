

 const questionslist = [

    {'questionText':
        "The systems which allow only one process execution at a time, are called __________  ",
      'answers': [{'text':'uniprogramming systems', 'score': false},
        {'text':'uniprocessing systems', 'score':true},
        {'text':'unitasking systems', 'score':false},
        {'text':'None of the above', 'score':false}],
        'correctAns': 'uniprocessing systems',
        'explanation': 'User level threads are managed by thread library and the kernel is unaware of them.'
        },

    {'questionText': 'In Unix, Which system call creates the new process?',
      'answers': [{'text':'fork', 'score':true},
        {'text': 'new', 'score': false},
        {'text': 'create', 'score':false},
        {'text':'none of the mentioned', 'score':false}],
        'correctAns': 'fork',
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