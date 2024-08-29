import { ABOUT_TEXT } from "../constants";

const About = () => {
  return (
    <div className="border-b border-gray-300 pb-4 bg-white">
      <h1 className="my-10 text-center text-4xl text-gray-800">
        About <span className="text-gray-600">Me</span>
      </h1>
      <div className="flex flex-wrap justify-center">
        <div className="w-full lg:w-1/2 flex justify-center">
          <div className="text-center">
            <p className="my-2 max-w-xl py-6 text-gray-700">{ABOUT_TEXT}</p>
          </div>
        </div>
      </div>
    </div>
  );
};

export default About;
