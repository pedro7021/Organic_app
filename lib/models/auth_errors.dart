String getErrorString(String code) {
  switch (code) {
    case 'Auth.form.error.email.provide':
      return 'Por favor providencie seu e-mail ou usuário.';
    case 'Auth.form.error.password.provide':
      return 'Por favor providencie sua senha.';
    case 'Auth.form.error.invalid':
      return 'Login ou senha inválidos.';
    case 'Auth.form.error.confirmed':
      return 'Seu e-mail não foi confirmado.';
    case 'Auth.form.error.blocked':
      return "Sua conta foi bloqueada por um administrador";
    case 'Auth.form.error.password.local':
      return 'Este usuário nunca adicionou uma senha, por favor faça login com o provedor utilizado durante a crianção da conta.';
    case 'Auth.form.error.password.matching':
      return 'Senhas não coincidem.';
    case 'Auth.form.error.email.format':
      return 'Por favor providencie um email valido.';
    case 'Auth.form.error.user.not-exist':
      return 'o email informado não existe.';
    case 'Auth.form.error.user.blocked':
      return 'Esse usuário está desabilitado.';
    case 'Auth.form.error.password.format':
      return 'Sua senha não pode conter mais do que três vezes o símbolo `\$`.';
    case 'Auth.form.error.role.notFound':
      return 'Impossível de encontrar o papel padrão.';
    case 'Auth.form.error.email.taken':
      return 'Esse email já foi ocupado.';
    case 'Auth.form.error.username.taken':
      return 'Nome de usuário já foi ocupado.';
    default:
      return 'Um erro indefinido ocorreu.';
  }
}
