import { FaExternalLinkAlt } from "react-icons/fa";
import { RiMoonClearFill, RiSunFill } from "react-icons/ri";
import { useState } from "react";
import logo from "../assets/lorenzoLogo.jpeg";


const Contact = () => {
  const [isDarkMode, setIsDarkMode] = useState(true);

  const toggleDarkMode = () => {
    setIsDarkMode(!isDarkMode);
    document.documentElement.classList.toggle("dark");
  };

  return (
    <div className="flex flex-col items-center justify-between mb-10 border-t border-neutral-300 pt-10 mt-20 lg:flex-row lg:space-y-0 lg:px-20">
      {/* Logo */}
      <div className="flex-shrink-0 mb-10 lg:mb-0 lg:w-1/4 flex justify-center lg:justify-start">
        <img src={logo} alt="Logo" className="w-10 rounded-full scale-150 " />
      </div>

      {/* Main Content */}
      <div className="flex flex-col lg:flex-row lg:w-3/4 lg:justify-between lg:items-start lg:space-x-4">
        {/* Craft Section */}
        <div className="flex flex-col text-left lg:w-1/3 lg:justify-start mb-10 lg:mb-0">
          <h3 className="text-xs uppercase tracking-wider text-gray-600 font-semibold mb-2">Craft</h3>
          <div className="flex flex-col space-y-2">
            <p className="text-sm text-gray-800 font-bold">Craft 1</p>
            <p className="text-sm text-gray-800 font-bold">Craft 2</p>
            <p className="text-sm text-gray-800 font-bold">Craft 3</p>
          </div>
        </div>

        {/* Contact Section */}
        <div className="flex flex-col text-left lg:w-1/3 lg:justify-start mb-10 lg:mb-0">
          <h3 className="text-xs uppercase tracking-wider text-gray-600 font-semibold mb-2">Contact</h3>
          <div className="flex flex-col space-y-2">
            <a
              href="https://www.linkedin.com/in/yourprofile"
              className="flex items-center space-x-2 font-bold text-sm text-gray-800 hover:text-blue-500"
            >
              <span>LinkedIn</span>
              <FaExternalLinkAlt />
            </a>
            <a
              href="https://read.cv/yourprofile"
              className="flex items-center space-x-2 font-bold text-sm text-gray-800 hover:text-blue-500"
            >
              <span>Read.cv</span>
              <FaExternalLinkAlt />
            </a>
            <a
              href="mailto:your.email@example.com"
              className="flex items-center space-x-2 font-bold text-sm text-gray-800 hover:text-blue-500"
            >
              <span>Mail</span>
              <FaExternalLinkAlt />
            </a>
          </div>
        </div>
      </div>

      {/* Dark Mode Toggle and Footer */}
      <div className="flex flex-col items-center lg:items-end lg:w-1/4 space-y-4 mt-10 lg:mt-0">
        <button
          onClick={toggleDarkMode}
          className="flex items-center space-x-2 text-sm text-gray-800 hover:text-blue-500"
        >
          {isDarkMode ? <RiSunFill /> : <RiMoonClearFill />}
          <span>{isDarkMode ? "Light Mode" : "Dark Mode"}</span>
        </button>
        <p className="text-xs text-gray-800 text-center lg:text-right">© 2024 TESTE 123. PIPIPIPOPO</p>
        <p className="text-xs text-gray-800 text-center lg:text-right">
          Made with 🍵 and Strawberry Matcha Lattes (120% sugar, less ice).
        </p>
      </div>
    </div>
  );
};

export default Contact;
