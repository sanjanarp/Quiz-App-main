const questionslist = [

    {'questionText':
        "The processes that are residing in main memory and are ready and waiting to execute are kept on a list called _____________",
      'answers': [{'text':' ready queue', 'score': true},
        {'text':'job queue', 'score':false},
        {'text':'execution queue', 'score':false},
        {'text':'process queue', 'score':false}],
        'correctAns': ' ready queue',
        'explanation': 'User level threads are managed by thread library and the kernel is unaware of them.'
        }, 

    {'questionText': 'Which one of the following can not be scheduled by the kernel?',
      'answers': [{'text':'kernel level thread', 'score':false},
        {'text': 'user level thread', 'score': true},
        {'text': 'process', 'score':false},
        {'text':'none of the mentioned', 'score':false}],
        'correctAns': 'user level thread',
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