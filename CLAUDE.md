# OpenWolf

@.wolf/OPENWOLF.md

This project uses OpenWolf for context management. Read and follow .wolf/OPENWOLF.md every session. Check .wolf/cerebrum.md before generating code. Check .wolf/anatomy.md before reading files.

## Model & Effort Recommendation

Before starting any plan or edit, analyze the task described in the user's prompt and 
recommend the most suitable model, effort level, and whether extended thinking should be 
enabled, to complete the task in under 15 minutes. State the recommendation explicitly at 
the start of the response, with a one-line reason, before proceeding. Use this guide:

- **Trivial/mechanical** (typo fixes, renaming a field, fixing a single failing test with an 
  obvious cause, small attribute changes in a model/entity) → **Haiku or Sonnet, effort: low, 
  thinking: off**. The answer should come from pattern recognition, not deliberation.
- **Routine implementation** (adding a function with contained logic, wiring a known pattern, 
  fixing a test that needs light reasoning) → **Sonnet, effort: low-medium, thinking: off**, 
  unless the logic has a non-obvious edge case — in that case keep the same model/effort but 
  turn **thinking: on** for that one step rather than raising effort.
- **Multi-file feature work with design decisions** (new feature scaffold spanning data/domain/
  presentation layers, new routing, or work that mirrors an existing pattern in the codebase) → 
  **Sonnet, effort: high, thinking: on** if a clear existing pattern exists to mirror; otherwise 
  **opusplan, effort: high, thinking: on** (Opus plans the layer boundaries and interfaces with 
  thinking enabled, Sonnet implements).
- **Architecture, complex refactors, hard bugs** (race conditions, cross-cutting refactors, 
  ambiguous system design, debugging with many interacting variables) → **Opus, effort: high or 
  xhigh, thinking: on**. These need the model to trace causality and weigh tradeoffs, not just 
  produce output.

Default to the lowest model/effort/thinking combination that can reliably produce a correct 
result. Do not enable thinking or raise effort for tasks that are mechanical or well-scoped, 
and do not disable thinking for tasks with real design ambiguity, debugging depth, or 
architectural tradeoffs — even if the model/effort tier is otherwise modest. If the current 
session's settings don't match the recommendation, pause and ask the user whether to switch 
before proceeding.

## Code conventions (required)

These apply to **all** Dart/Flutter code in this project. Treat each as a merge blocker.

### One widget per file
- **Every widget class lives in its own file** — never declare two `Widget` classes (public *or* private) in the same file. If a `build()` method grows a sub-widget, extract it into a new file under the screen's `widgets/` folder (or `shared/presentation/widgets/` if reused). Private `_Foo` helper widgets must also be split out into their own files as public widgets.
- **Never write a private method that returns `Widget`** — no `Widget _buildXxx(...)`, no `Widget _buildXxx(BuildContext context)`. These are a merge blocker exactly like declaring two widget classes in one file. Extract the body into a named `StatelessWidget` in its own file instead.

### Spacing constants — `AppSpace` for gaps, `AppPadding` for padding, `AppMargin` for margins
- **Gaps use `AppSpace.sX`** — e.g. `const Gap(AppSpace.s16)`.
- **Paddings use `AppPadding.pX`** — e.g. `const EdgeInsets.symmetric(horizontal: AppPadding.p24)`, `padding: const EdgeInsets.all(AppPadding.p8)`.
- **Margins use `AppMargin.mX`** — e.g. `margin: const EdgeInsets.only(bottom: AppMargin.m16)`.
- All three are plain `const` doubles. **Never** add a ScreenUtil suffix to a gap / padding / margin (no `AppPadding.p16.w`, no `AppSpace.s16.h`).
- **ScreenUtil suffixes are reserved for dimensions only:** `.w` for width, `.h` for height, `.r` for border radius (and `.spMin` for square icon/image sizes).

### Colors — always use `AppColors`
- **Never write a raw `Color(0xFF...)` hex literal in a widget.** Add a named constant to `lib/core/themes/app_colors.dart` and reference it.
- Feature-specific color groups are documented with a `// ---------- Feature ----------` comment block inside `AppColors`.
- **Add-kid sheet colors** (`lib/core/themes/app_colors.dart`, section `Add-kid sheet`):
  - `AppColors.addKidGradientStart` — header + primary button gradient start.
  - `AppColors.addKidGradientEnd` — gradient end / selected-state fill (gender pill, age button, avatar ring).
  - `AppColors.addKidSuccessCardBorder` — light-lavender border on the success card.

### Feature dimension constants — `AddKidDimens` and per-feature classes in `app_values.dart`
- **Never write a raw numeric literal for a widget dimension** (icon size, slider height, border width, border radius base). Add it to the matching feature dimensions class in `lib/core/constants/app_values.dart`.
- **Add-kid sheet dimensions** — `AddKidDimens` (in `app_values.dart`): covers avatar slider height, icon sizes, button arrow icon size, border widths, and all border-radius base values used by the add-kid sheet.  Apply `.w`/`.h`/`.r`/`.spMin` at the use site as per the ScreenUtil rule above.

### Comment / explain every piece of code
- Document every widget, Cubit, use case, repository, data source, and model with a `///` doc comment describing its responsibility.
- Explain non-obvious logic, branches, and design decisions with inline `//` comments. Code should be readable without the reader reverse-engineering intent.

### Always use the shared widget when one exists
- Before writing UI, check `shared/presentation/widgets/`. If a shared widget covers the need, **use it** — never a bare equivalent:
  - text → `AppText` (never bare `Text(...)`)
  - button → `AppButtonWidget` (never `ElevatedButton`/`TextButton`/standalone `InkWell`)
  - text input → `AppTextField`
  - screen root → `AppScaffold` (never bare `Scaffold`)
  - network image → `AppCachedImage`
  - loading → `AppLoadingWidget`
- This is mandatory even inside transient UI such as `SnackBar` content.

## Superpowers Workflow (required)

This project uses the **Superpowers** plugin (v5.1.0). Apply the matching skill at each stage — do not skip them. At the start of any task, state which Superpowers skill applies and invoke it before producing code.

### Feature documentation (required)

Every feature must have a living doc at `lib/features/<feature_name>/docs/<feature_name>.md`.

**Rules:**
- When `/brainstorming` or `/writing-plans` generates a design spec or implementation plan, save it to `lib/features/<feature_name>/docs/<feature_name>.md` — **not** to `docs/superpowers/`. Discard or ignore any file written to `docs/superpowers/` and write the equivalent content to the feature doc path instead.
- The doc must contain: feature purpose, architecture overview (layers, key classes, data flow), API endpoints used, state management approach, routing, and any non-obvious decisions.
- **Every time code in a feature is created or modified**, update `lib/features/<feature_name>/docs/<feature_name>.md` to reflect the change — keep the doc in sync with the code at all times. This is mandatory and must happen in the same session as the code change.
- Never leave the doc stale. If a class is renamed, an endpoint changes, or a flow is added, the doc must be updated before the task is considered done.

### Planning & design
- **Before any creative work** — designing a new project, feature, component, or architecture — run `/brainstorming` first to explore scope, edge cases, and approaches.
- **Turning a chosen approach into a concrete plan** — run `/writing-plans` to author a structured implementation plan.

### Execution
- **Executing a written plan** — run `/executing-plans` in a focused session.
- **2+ independent, non-conflicting tasks** — run `/dispatching-parallel-agents` to work them in parallel.
- **Delegating focused chunks to subagents** — run `/subagent-driven-development`.
- **Working on isolated copies of the repo** — run `/using-git-worktrees`.

### Testing (required)

Every new feature must have tests written **before** the implementation code (TDD — run `/test-driven-development` first). The test folder mirrors the exact same Clean Architecture layers as `lib/`:

#### Test folder structure

```
test/
├── helpers/
│   ├── mocks/
│   │   ├── mock_repositories.dart       # @GenerateMocks for all repository interfaces
│   │   ├── mock_data_sources.dart       # @GenerateMocks for all data source interfaces
│   │   └── mock_use_cases.dart          # @GenerateMocks for all use cases
│   └── fixtures/
│       └── <feature>_fixtures.dart      # fake/stub domain entities and response models
├── shared/
│   ├── data/
│   │   ├── models/                      # fromJson / toDomain / toJson unit tests
│   │   └── repositories/               # repository impl tests (mock data source)
│   └── domain/
│       └── usecases/                    # use case unit tests (mock repository)
└── features/
    └── <feature>/
        ├── data/
        │   ├── datasources/
        │   │   └── <feature>_remote_data_source_test.dart   # mock DioClientService
        │   ├── models/
        │   │   └── <feature>_response_test.dart             # fromJson + toDomain
        │   └── repositories/
        │       └── <feature>_repository_impl_test.dart      # mock data source
        ├── domain/
        │   └── usecases/
        │       └── <feature>_usecase_test.dart              # mock repository
        └── presentation/
            └── <screen>/
                ├── cubit/
                │   └── <screen>_cubit_test.dart             # blocTest, mock use case
                └── screens/
                    └── <screen>_test.dart                   # widget test, mock cubit
```

#### Layer-by-layer rules

**Data layer — models**
- Test `fromJson()` with a raw JSON map fixture — assert every field maps correctly.
- Test `toDomain()` — assert the returned entity has the correct field values.
- Test `toJson()` (request models) — assert the output map matches `ApiParameterConstant` keys.

```dart
test('fromJson maps all fields correctly', () {
  final json = LoginFixtures.loginResponseJson;
  final model = LoginResponse.fromJson(json);
  expect(model.token, LoginFixtures.token);
});

test('toDomain returns correct entity', () {
  final entity = LoginFixtures.loginResponse.toDomain();
  expect(entity.token, LoginFixtures.token);
});
```

**Data layer — data sources**
- Mock `DioClientService` with `mocktail` or `mockito`.
- Test success path: mock returns valid JSON → assert `Right(model)`.
- Test failure path: mock throws `DioException` → assert `Left(AppError)`.

```dart
test('login returns Right on 200', () async {
  when(() => mockDio.post(AppEndpoints.login, data: any(named: 'data')))
      .thenAnswer((_) async => Response(data: LoginFixtures.loginResponseJson, ...));
  final result = await dataSource.login(identifier: 'u', password: 'p');
  expect(result.isRight(), true);
});
```

**Data layer — repository implementations**
- Mock the data source interface.
- Test success: data source returns `Right` → repository returns `Right(entity)` via `toDomain()`.
- Test failure: data source returns `Left(AppError)` → repository propagates `Left`.

**Domain layer — use cases**
- Mock the repository interface.
- Test success: repository returns `Right` → use case returns `Right` (apply any business logic assertions).
- Test failure: repository returns `Left(AppError)` → use case returns `Left`.
- Never instantiate a real repository or data source in a use case test.

```dart
test('returns filtered active users on success', () async {
  when(() => mockRepo.getUsers())
      .thenAnswer((_) async => Right(UserFixtures.mixedUsers));
  final result = await useCase();
  expect(result.getOrElse(() => []).every((u) => u.isActive), true);
});
```

**Presentation layer — Cubits**
- Mock all injected use cases.
- Use `blocTest` for every scenario: initial state, loading emitted before async work, success emits, error emits.
- Never test navigation directly — assert the Cubit emits the correct terminal state; navigation is the router's concern.

```dart
blocTest<LoginCubit, LoginState>(
  'emits loading then success state',
  build: () {
    when(() => mockLoginUseCase(identifier: any(named:'identifier'), password: any(named:'password')))
        .thenAnswer((_) async => Right(LoginFixtures.loginResult));
    return LoginCubit(mockLoginUseCase, mockRouter);
  },
  act: (c) => c.submit(onSuccess: () {}, onError: (_) {}),
  expect: () => [
    isA<LoginState>().having((s) => s.isSubmitting, 'loading', true),
    isA<LoginState>().having((s) => s.isSubmitting, 'done', false),
  ],
);
```

**Presentation layer — widget tests**
- Run `/flutter-add-widget-test` for every new screen.
- Provide the Cubit via `BlocProvider` with a mock or fake.
- Find widgets using `TestKeys` constants only — never by text label or widget type alone.
- Assert visible state changes: loading indicator appears, error text shown, button disabled while submitting.

**Integration tests**
- Run `/flutter-add-integration-test` for critical end-to-end flows (login, core actions).
- One integration test file per user journey under `integration_test/`.

#### Fixtures & helpers (required)

Every feature must have a fixtures file at `test/helpers/fixtures/<feature>_fixtures.dart` that provides:
- Hardcoded JSON maps (raw API response)
- Pre-built domain entity instances
- Pre-built response model instances

```dart
// test/helpers/fixtures/auth_fixtures.dart
class AuthFixtures {
  static const token = 'test-token-123';

  static final loginResponseJson = {
    ApiParameterConstant.token: token,
    ApiParameterConstant.user: UserFixtures.userJson,
  };

  static final loginResponse = LoginResponse.fromJson(loginResponseJson);
  static final loginResult   = loginResponse.toDomain();
}
```

#### General rules
- **Before writing any feature code** — run `/test-driven-development`: write failing tests first, then implement the minimal code to pass them.
- **Every time a feature is modified** — update the matching test file in the same session. A code change with no test update is not complete.
- **Never call `getIt`** inside any test — inject all dependencies via constructor.
- **Never use real network calls** in unit or widget tests — always mock `DioClientService`.
- All mock classes live in `test/helpers/mocks/`. Use `@GenerateMocks([...])` from `mockito` or `mocktail` — never hand-write mocks.
- Run `/flutter-add-widget-test` for screens and `/flutter-add-integration-test` for user flows.

### Quality & correctness
- **Creating any new feature OR modifying existing code** — run `/flutter-pr-review` on the generated/changed code to verify it matches this project's Clean Architecture, layer boundaries, state management, DI, networking, routing, UI conventions, and naming rules. This is **mandatory** for every code change before it is considered done — treat any 🔴 finding as a blocker and fix it before moving on.
- **Finding and fixing a bug** — run `/systematic-debugging` for a methodical root-cause approach.
- **Before marking any work done** — run `/verification-before-completion` to confirm it actually does what it should.

### Review & integration
- **Before merging or opening a PR** — run `/requesting-code-review` (complements the PR checklist in `PR_GUIDELINES.md`).
- **When acting on review feedback** — run `/receiving-code-review` before implementing the suggestions.
- **After implementation is complete and all tests pass** — run `/finishing-a-development-branch` to decide how to integrate.

### Meta
- **Unsure which skill applies** — run `/using-superpowers` to discover the right one.
- **Capturing a repeatable workflow as a new skill** — run `/writing-skills`.
