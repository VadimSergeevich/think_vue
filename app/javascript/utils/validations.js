const emailPattern = /^(?=[a-zA-Z0-9@._%+-]{6,254}$)[a-zA-Z0-9._%+-]{1,64}@(?:[a-zA-Z0-9-]{1,63}\.){1,8}[a-zA-Z]{2,63}$/;

const onlyDigitals = v => /^\d+$/.test(v) || 'Only digital';
const inn = v => [10, 12].includes(v.length) || 'Must be 10 or 12 digitals';
const email = v => emailPattern.test(v) || 'Please enter a valid email address';
const required = v => !!v || 'Field is required';
const minLength = (v, length) => v.length >= length || `Min ${length}`;

export { onlyDigitals, inn, email, required, minLength };
