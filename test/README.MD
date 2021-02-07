> Q: Why tests are placed into a separate folder, as opposed to having them closer to the code under test?

> A: Because you don't want to test the code, you want to test the program.


├── ...
├── test                    # Test files (alternatively `spec` or `tests`)
│   ├── benchmarks          # Load and stress tests
│   ├── integration         # End-to-end, integration tests (alternatively `e2e`)
│   └── unit                # Unit tests
└── ... `

