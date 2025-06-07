import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/constants.dart';
import 'package:portfolio/widgets/animated_text.dart';
import 'dart:async';
import 'dart:math';
import 'package:flutter/services.dart';

class MobileMockupSection extends StatefulWidget {
  const MobileMockupSection({super.key});

  @override
  State<MobileMockupSection> createState() => _MobileMockupSectionState();
}

class _MobileMockupSectionState extends State<MobileMockupSection>
    with SingleTickerProviderStateMixin {
  bool _isAppOpen = false;
  int _currentAppIndex = 0;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;
  late Timer _timer;
  late String _currentTime;
  late String _currentDate;
  bool _isLocked = true;
  double _slideProgress = 0.0;

  final List<Map<String, dynamic>> _apps = [
    {
      'name': 'Calculator',
      'icon': Icons.calculate,
      'color': Colors.orange,
      'widget': const CalculatorApp(),
    },
    {
      'name': 'Tic Tac Toe',
      'icon': Icons.grid_3x3,
      'color': Colors.green,
      'widget': const TicTacToeApp(),
    },
    {
      'name': 'Sudoku',
      'icon': Icons.grid_4x4,
      'color': Colors.purple,
      'widget': const SudokuApp(),
    },
    {
      'name': 'Calendar',
      'icon': Icons.calendar_today,
      'color': Colors.red,
      'widget': const CalendarApp(),
    },
    {
      'name': 'Terminal',
      'icon': Icons.terminal,
      'color': Colors.grey[800]!,
      'widget': const TerminalApp(),
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    // Initialize time and date
    _updateDateTime();

    // Update time every second
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateDateTime();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _animationController.dispose();
    super.dispose();
  }

  void _updateDateTime() {
    final now = DateTime.now();
    setState(() {
      _currentTime =
          '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
      _currentDate =
          '${_getDayName(now.weekday)}, ${_getMonthName(now.month)} ${now.day}';
    });
  }

  String _getDayName(int day) {
    switch (day) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return '';
    }
  }

  String _getMonthName(int month) {
    switch (month) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        return '';
    }
  }

  void _openApp(int index) {
    setState(() {
      _currentAppIndex = index;
      _isAppOpen = true;
    });
    _animationController.forward();
  }

  void _closeApp() {
    _animationController.reverse().then((_) {
      setState(() {
        _isAppOpen = false;
      });
    });
  }

  void _unlockPhone() {
    setState(() {
      _isLocked = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 600,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: Colors.grey[800]!, width: 2),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(38),
        child: Stack(
          children: [
            if (_isLocked)
              LockScreen(
                currentTime: _currentTime,
                currentDate: _currentDate,
                slideProgress: _slideProgress,
                onSlideUpdate: (progress) {
                  setState(() {
                    _slideProgress = progress;
                  });
                },
                onUnlock: _unlockPhone,
              )
            else if (_isAppOpen)
              Column(
                children: [
                  // Status Bar
                  Container(
                    height: 24,
                    color: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _currentTime,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(Icons.signal_cellular_alt,
                                color: Colors.white, size: 14),
                            const SizedBox(width: 4),
                            Icon(Icons.wifi, color: Colors.white, size: 14),
                            const SizedBox(width: 4),
                            Icon(Icons.battery_full,
                                color: Colors.white, size: 14),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: _apps[_currentAppIndex]['widget'],
                  ),
                  // Navigation Bar
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Back button
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 24,
                          ),
                          onPressed: _closeApp,
                        ),
                        // Home button
                        GestureDetector(
                          onTap: _closeApp,
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                          ),
                        ),
                        // Recent apps button
                        IconButton(
                          icon: const Icon(
                            Icons.square_outlined,
                            color: Colors.white,
                            size: 24,
                          ),
                          onPressed: _closeApp,
                        ),
                      ],
                    ),
                  ),
                ],
              )
            else
              HomeScreen(
                currentTime: _currentTime,
                currentDate: _currentDate,
                onLock: () {
                  setState(() {
                    _isLocked = true;
                    _slideProgress = 0.0;
                  });
                },
                onOpenApp: _openApp,
                apps: _apps,
              ),
          ],
        ),
      ),
    );
  }
}

class LockScreen extends StatelessWidget {
  final String currentTime;
  final String currentDate;
  final double slideProgress;
  final Function(double) onSlideUpdate;
  final VoidCallback onUnlock;

  const LockScreen({
    super.key,
    required this.currentTime,
    required this.currentDate,
    required this.slideProgress,
    required this.onSlideUpdate,
    required this.onUnlock,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.blue[900]!,
            Colors.black,
          ],
        ),
        image: const DecorationImage(
          image: AssetImage('assets/lockscreen.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          // Status Bar
          Container(
            height: 24,
            color: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  currentTime,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.signal_cellular_alt,
                        color: Colors.white, size: 14),
                    const SizedBox(width: 4),
                    Icon(Icons.wifi, color: Colors.white, size: 14),
                    const SizedBox(width: 4),
                    Icon(Icons.battery_full, color: Colors.white, size: 14),
                  ],
                ),
              ],
            ),
          ),
          const Spacer(),
          // Time and Date
          Text(
            currentTime,
            style: GoogleFonts.poppins(
              fontSize: 48,
              fontWeight: FontWeight.w300,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            currentDate,
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),
          const Spacer(),
          // Slide to Unlock
          GestureDetector(
            onHorizontalDragUpdate: (details) {
              final newProgress =
                  (slideProgress + details.delta.dx / 100).clamp(0.0, 1.0);
              onSlideUpdate(newProgress);
              if (newProgress >= 0.5) {
                onUnlock();
              }
            },
            onHorizontalDragEnd: (_) {
              if (slideProgress < 1.0) {
                onSlideUpdate(0.0);
              }
            },
            child: Container(
              height: 60,
              margin: const EdgeInsets.only(bottom: 40),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Transform.translate(
                    offset: Offset(slideProgress * 50, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Slide to unlock',
                          style: GoogleFonts.poppins(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final String currentTime;
  final String currentDate;
  final VoidCallback onLock;
  final Function(int) onOpenApp;
  final List<Map<String, dynamic>> apps;

  const HomeScreen({
    super.key,
    required this.currentTime,
    required this.currentDate,
    required this.onLock,
    required this.onOpenApp,
    required this.apps,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/lockscreen.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          // Status Bar
          Container(
            height: 24,
            color: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  currentTime,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.signal_cellular_alt,
                        color: Colors.white, size: 14),
                    const SizedBox(width: 4),
                    Icon(Icons.wifi, color: Colors.white, size: 14),
                    const SizedBox(width: 4),
                    Icon(Icons.battery_full, color: Colors.white, size: 14),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          // Time
          Text(
            currentTime,
            style: GoogleFonts.poppins(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          // Date
          Text(
            currentDate,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.white.withOpacity(0.8),
            ),
          ),
          const SizedBox(height: 20),
          // App Grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.2,
              ),
              itemCount: apps.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => onOpenApp(index),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: apps[index]['color'] as Color,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: (apps[index]['color'] as Color)
                                  .withOpacity(0.3),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Icon(
                          apps[index]['icon'] as IconData,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        apps[index]['name'] as String,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          // Navigation Bar
          Container(
            height: 50,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Back button
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 24,
                  ),
                  onPressed: onLock,
                ),
                // Home button
                GestureDetector(
                  onTap: onLock,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
                // Recent apps button
                IconButton(
                  icon: const Icon(
                    Icons.square_outlined,
                    color: Colors.white,
                    size: 24,
                  ),
                  onPressed: onLock,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Calculator App
class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  String _display = '0';
  String _currentNumber = '';
  String _operation = '';
  double _firstNumber = 0;

  void _onNumberPress(String number) {
    setState(() {
      if (_display == '0') {
        _display = number;
      } else {
        _display += number;
      }
      _currentNumber = _display;
    });
  }

  void _onOperationPress(String operation) {
    setState(() {
      _firstNumber = double.parse(_display);
      _operation = operation;
      _display = '0';
    });
  }

  void _onEqualsPress() {
    setState(() {
      double secondNumber = double.parse(_currentNumber);
      switch (_operation) {
        case '+':
          _display = (_firstNumber + secondNumber).toString();
          break;
        case '-':
          _display = (_firstNumber - secondNumber).toString();
          break;
        case '×':
          _display = (_firstNumber * secondNumber).toString();
          break;
        case '÷':
          _display = (_firstNumber / secondNumber).toString();
          break;
      }
    });
  }

  void _onClearPress() {
    setState(() {
      _display = '0';
      _currentNumber = '';
      _operation = '';
      _firstNumber = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const SizedBox(height: 40),
          Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.bottomRight,
            child: Text(
              _display,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.count(
              crossAxisCount: 4,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: [
                _buildButton('C', Colors.red, _onClearPress),
                _buildButton('±', Colors.grey, () {}),
                _buildButton('%', Colors.grey, () {}),
                _buildButton('÷', Colors.orange, () => _onOperationPress('÷')),
                _buildButton('7', Colors.grey[800]!, () => _onNumberPress('7')),
                _buildButton('8', Colors.grey[800]!, () => _onNumberPress('8')),
                _buildButton('9', Colors.grey[800]!, () => _onNumberPress('9')),
                _buildButton('×', Colors.orange, () => _onOperationPress('×')),
                _buildButton('4', Colors.grey[800]!, () => _onNumberPress('4')),
                _buildButton('5', Colors.grey[800]!, () => _onNumberPress('5')),
                _buildButton('6', Colors.grey[800]!, () => _onNumberPress('6')),
                _buildButton('-', Colors.orange, () => _onOperationPress('-')),
                _buildButton('1', Colors.grey[800]!, () => _onNumberPress('1')),
                _buildButton('2', Colors.grey[800]!, () => _onNumberPress('2')),
                _buildButton('3', Colors.grey[800]!, () => _onNumberPress('3')),
                _buildButton('+', Colors.orange, () => _onOperationPress('+')),
                _buildButton('0', Colors.grey[800]!, () => _onNumberPress('0')),
                _buildButton('.', Colors.grey[800]!, () => _onNumberPress('.')),
                _buildButton('=', Colors.orange, _onEqualsPress),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String text, Color color, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          shape: text == '0' ? BoxShape.rectangle : BoxShape.circle,
          borderRadius: text == '0' ? BorderRadius.circular(35) : null,
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

// Tic Tac Toe App
class TicTacToeApp extends StatefulWidget {
  const TicTacToeApp({super.key});

  @override
  State<TicTacToeApp> createState() => _TicTacToeAppState();
}

class _TicTacToeAppState extends State<TicTacToeApp> {
  List<String> _board = List.filled(9, '');
  bool _isXTurn = true;
  String? _winner;

  void _onCellTap(int index) {
    if (_board[index].isEmpty && _winner == null) {
      setState(() {
        _board[index] = _isXTurn ? 'X' : 'O';
        _isXTurn = !_isXTurn;
        _checkWinner();
      });
    }
  }

  void _checkWinner() {
    // Check rows
    for (int i = 0; i < 9; i += 3) {
      if (_board[i].isNotEmpty &&
          _board[i] == _board[i + 1] &&
          _board[i] == _board[i + 2]) {
        _winner = _board[i];
        return;
      }
    }

    // Check columns
    for (int i = 0; i < 3; i++) {
      if (_board[i].isNotEmpty &&
          _board[i] == _board[i + 3] &&
          _board[i] == _board[i + 6]) {
        _winner = _board[i];
        return;
      }
    }

    // Check diagonals
    if (_board[0].isNotEmpty &&
        _board[0] == _board[4] &&
        _board[0] == _board[8]) {
      _winner = _board[0];
      return;
    }
    if (_board[2].isNotEmpty &&
        _board[2] == _board[4] &&
        _board[2] == _board[6]) {
      _winner = _board[2];
      return;
    }

    // Check for draw
    if (!_board.contains('')) {
      _winner = 'Draw';
    }
  }

  void _resetGame() {
    setState(() {
      _board = List.filled(9, '');
      _isXTurn = true;
      _winner = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 43, 42, 42),
      child: Column(
        children: [
          const SizedBox(height: 30),
          Text(
            'Tic Tac Toe',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[200],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Center(
              child: AspectRatio(
                aspectRatio: 1,
                child: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                  ),
                  itemCount: 9,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => _onCellTap(index),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 107, 104, 104),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            _board[index],
                            style: GoogleFonts.poppins(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: _board[index] == 'X'
                                  ? Colors.blue[300]
                                  : Colors.red[300],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          if (_winner != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                children: [
                  Text(
                    _winner == 'Draw' ? 'Game Draw!' : 'Player $_winner Wins!',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[200],
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _resetGame,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 107, 104, 104),
                      foregroundColor: Colors.grey[200],
                    ),
                    child: const Text('Play Again'),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

// Sudoku App
class SudokuApp extends StatefulWidget {
  const SudokuApp({super.key});

  @override
  State<SudokuApp> createState() => _SudokuAppState();
}

class _SudokuAppState extends State<SudokuApp> {
  late List<List<int>> _board;
  late List<List<bool>> _isFixed;
  int? _selectedCell;

  @override
  void initState() {
    super.initState();
    _initializeBoard();
  }

  void _initializeBoard() {
    // Initialize with a simple puzzle
    _board = List.generate(9, (i) => List.generate(9, (j) => 0));
    _isFixed = List.generate(9, (i) => List.generate(9, (j) => false));

    // Add some fixed numbers
    _board[0][0] = 5;
    _board[0][4] = 3;
    _board[1][2] = 7;
    _board[2][1] = 9;
    _board[3][3] = 6;
    _board[4][4] = 1;
    _board[5][5] = 8;
    _board[6][7] = 4;
    _board[7][8] = 2;
    _board[8][6] = 3;

    // Mark fixed numbers
    for (int i = 0; i < 9; i++) {
      for (int j = 0; j < 9; j++) {
        if (_board[i][j] != 0) {
          _isFixed[i][j] = true;
        }
      }
    }
  }

  void _selectCell(int index) {
    if (!_isFixed[index ~/ 9][index % 9]) {
      setState(() {
        _selectedCell = index;
      });
    }
  }

  void _setNumber(int number) {
    if (_selectedCell != null) {
      setState(() {
        _board[_selectedCell! ~/ 9][_selectedCell! % 9] = number;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 43, 42, 42), // Dark background
      child: Column(
        children: [
          const SizedBox(height: 30),
          Text(
            'Sudoku',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[200],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 9,
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
                childAspectRatio: 1,
              ),
              itemCount: 81,
              itemBuilder: (context, index) {
                final row = index ~/ 9;
                final col = index % 9;
                final isSelected = index == _selectedCell;
                final isFixed = _isFixed[row][col];
                final value = _board[row][col];
                final isBoxBorder = row % 3 == 0 || col % 3 == 0;

                return GestureDetector(
                  onTap: () => _selectCell(index),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.blue.withOpacity(0.1)
                          : Colors.grey[50],
                      border: Border(
                        top: BorderSide(
                          color: isBoxBorder ? Colors.white : Colors.grey[200]!,
                          width: isBoxBorder ? 2 : 1,
                        ),
                        left: BorderSide(
                          color: isBoxBorder ? Colors.white : Colors.grey[200]!,
                          width: isBoxBorder ? 2 : 1,
                        ),
                        right: BorderSide(
                          color: col == 8
                              ? (isBoxBorder ? Colors.white : Colors.grey[200]!)
                              : Colors.transparent,
                          width: isBoxBorder ? 2 : 1,
                        ),
                        bottom: BorderSide(
                          color: row == 8
                              ? (isBoxBorder ? Colors.white : Colors.grey[200]!)
                              : Colors.transparent,
                          width: isBoxBorder ? 2 : 1,
                        ),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        value == 0 ? '' : value.toString(),
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: isFixed ? Colors.black : Colors.blue[700],
                          fontWeight:
                              isFixed ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                9,
                (index) => GestureDetector(
                  onTap: () => _setNumber(index + 1),
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 107, 104, 104),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Calendar App
class CalendarApp extends StatefulWidget {
  const CalendarApp({super.key});

  @override
  State<CalendarApp> createState() => _CalendarAppState();
}

class _CalendarAppState extends State<CalendarApp> {
  late DateTime _currentDate;
  late String _monthYear;

  @override
  void initState() {
    super.initState();
    _currentDate = DateTime.now();
    _updateMonthYear();
  }

  void _updateMonthYear() {
    _monthYear = '${_getMonthName(_currentDate.month)} ${_currentDate.year}';
  }

  String _getMonthName(int month) {
    switch (month) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final firstDayOfMonth = DateTime(_currentDate.year, _currentDate.month, 1);
    final lastDayOfMonth =
        DateTime(_currentDate.year, _currentDate.month + 1, 0);
    final firstWeekday = firstDayOfMonth.weekday % 7;
    final daysInMonth = lastDayOfMonth.day;

    return Container(
      color: const Color.fromARGB(255, 43, 42, 42),
      child: Column(
        children: [
          const SizedBox(height: 30),
          Text(
            _monthYear,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[200],
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: ['S', 'M', 'T', 'W', 'T', 'F', 'S']
                  .map(
                    (day) => SizedBox(
                      width: 30,
                      child: Text(
                        day,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[400],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              itemCount: 42,
              itemBuilder: (context, index) {
                final dayNumber = index - firstWeekday + 1;
                final isCurrentMonth =
                    dayNumber > 0 && dayNumber <= daysInMonth;
                final isToday = isCurrentMonth && dayNumber == _currentDate.day;

                return Container(
                  decoration: BoxDecoration(
                    color: isToday
                        ? const Color.fromARGB(255, 107, 104, 104)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      isCurrentMonth ? dayNumber.toString() : '',
                      style: TextStyle(
                        color: isToday ? Colors.grey[200] : Colors.grey[400],
                        fontWeight:
                            isToday ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Terminal App
class TerminalApp extends StatefulWidget {
  const TerminalApp({super.key});

  @override
  State<TerminalApp> createState() => _TerminalAppState();
}

class _TerminalAppState extends State<TerminalApp> {
  final List<String> _messages = [];
  bool _isWaitingForInput = true;
  int? _selectedOption;
  final TextEditingController _inputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _showWelcomeMessage();
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  void _showWelcomeMessage() {
    setState(() {
      _messages.add('Welcome to my terminal! 👋');
      _showMenu();
    });
  }

  void _showMenu() {
    _messages.addAll([
      '',
      'What would you like to know?',
      '',
      '1. Want to know more about me?',
      '2. What do I do?',
      '3. My skills',
      '4. Contact me',
      '',
      'Enter a number (1-4):',
    ]);
  }

  void _handleInput(String input) {
    if (_isWaitingForInput) {
      int? option = int.tryParse(input);
      if (option != null && option >= 1 && option <= 4) {
        setState(() {
          _selectedOption = option;
          _messages.add('> $input');
          _showResponse(option);
          _showMenu();
        });
      } else {
        setState(() {
          _messages.add('> $input');
          _messages.add('Please enter a valid number (1-4)');
          _messages.add('');
          _showMenu();
        });
      }
      _inputController.clear();
    }
  }

  void _showResponse(int option) {
    switch (option) {
      case 1:
        _messages.addAll([
          'About Me:',
          'I am a passionate Flutter developer with a keen interest in creating beautiful and functional mobile applications.',
          'I love solving complex problems and turning ideas into reality through code.',
          '',
        ]);
        break;
      case 2:
        _messages.addAll([
          'What I Do:',
          'I develop cross-platform mobile applications using Flutter.',
          'I specialize in creating intuitive user interfaces and implementing complex features.',
          'I also contribute to open-source projects and share my knowledge through technical writing.',
          '',
        ]);
        break;
      case 3:
        _messages.addAll([
          'My Skills:',
          '- Flutter & Dart',
          '- Firebase',
          '- REST APIs',
          '- State Management',
          '',
        ]);
        break;
      case 4:
        _messages.addAll([
          'Contact Me:',
          'Email: abhishekjaison04@gmail.com\n',
          'LinkedIn: www.linkedin.com/in/abhishek-jaison/\n',
          'GitHub: github.com/Abhishek-jaison/',
          '',
        ]);
        break;
    }
  }

  void _resetTerminal() {
    setState(() {
      _messages.clear();
      _isWaitingForInput = true;
      _selectedOption = null;
      _showWelcomeMessage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        children: [
          // Terminal Header
          Container(
            height: 30,
            color: Colors.grey[900],
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Terminal',
                  style: GoogleFonts.firaCode(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                IconButton(
                  icon:
                      const Icon(Icons.refresh, color: Colors.white, size: 16),
                  onPressed: _resetTerminal,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),
          // Terminal Content
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ..._messages.map((message) => Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Text(
                            message,
                            style: GoogleFonts.firaCode(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        )),
                    if (_isWaitingForInput)
                      Row(
                        children: [
                          Text(
                            '> ',
                            style: GoogleFonts.firaCode(
                              color: Colors.green,
                              fontSize: 14,
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              controller: _inputController,
                              style: GoogleFonts.firaCode(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.zero,
                              ),
                              onSubmitted: _handleInput,
                              autofocus: true,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
