export interface ResourceLink {
  title: string;
  href: string;
  description: string;
}

export const toolResources = {
  gradeCalculator: {
    title: "Grade Calculator",
    href: "/grade-calculator/",
    description: "Calculate your current class average from assignment scores and total points."
  },
  finalExamCalculator: {
    title: "Final Exam Calculator",
    href: "/final-exam-calculator/",
    description: "Find the score you need on your final exam to reach your target grade."
  },
  whatGradeDoINeedCalculator: {
    title: "What Grade Do I Need Calculator",
    href: "/what-grade-do-i-need-calculator/",
    description: "Work backward from your goal to see the average you need on remaining coursework."
  },
  weightedGradeCalculator: {
    title: "Weighted Grade Calculator",
    href: "/weighted-grade-calculator/",
    description: "Calculate class averages when homework, quizzes, tests, and finals have different weights."
  },
  gpaCalculator: {
    title: "GPA Calculator",
    href: "/gpa-calculator/",
    description: "Estimate weighted and unweighted GPA using credits, course levels, and letter grades."
  }
} satisfies Record<string, ResourceLink>;

export const guideResources = {
  howToCalculateYourGrade: {
    title: "How do I calculate my grade?",
    href: "/how-to-calculate-your-grade/",
    description: "Learn how points, percentages, and weighted categories affect your current grade."
  },
  howFinalsAffectYourGrade: {
    title: "How much can a final exam affect my grade?",
    href: "/how-finals-affect-your-grade/",
    description: "See how final exam weight changes the score you need to reach your goal."
  },
  whatGradeDoINeedToPass: {
    title: "What grade do I need to pass a class?",
    href: "/what-grade-do-i-need-to-pass-a-class/",
    description: "Find out whether your passing target is still realistic."
  },
  isA70PassingGrade: {
    title: "Is a 70 a passing grade?",
    href: "/is-a-70-a-passing-grade/",
    description: "Understand common passing-grade cutoffs and why policies vary by school."
  },
  whatIsAGoodGpa: {
    title: "What is a good GPA?",
    href: "/what-is-a-good-gpa/",
    description: "Learn how GPA is interpreted for high school, college, and academic planning."
  },
  collegesWeightedOrUnweighted: {
    title: "Do colleges look at weighted or unweighted GPA?",
    href: "/do-colleges-look-at-weighted-or-unweighted-gpa/",
    description: "Compare weighted and unweighted GPA and when each one matters."
  },
  weightedVsUnweightedGpa: {
    title: "Weighted vs. Unweighted GPA",
    href: "/guides/weighted-vs-unweighted-gpa/",
    description: "Compare regular GPA with honors, AP, IB, and college-level weighting."
  },
  howWeightedGradesWork: {
    title: "How Weighted Grades Work",
    href: "/guides/how-weighted-grades-work/",
    description: "See how category weights change your average and why some assignments count more than others."
  },
  howToCalculateGpaWithCredits: {
    title: "How to Calculate GPA with Credits",
    href: "/guides/how-to-calculate-gpa-with-credits/",
    description: "Learn how credits and grade points combine into a semester or cumulative GPA."
  },
  counselorResourcePage: {
    title: "Grade Calculators for Students, Parents, and School Counselors",
    href: "/grade-calculators-for-students-parents-counselors/",
    description: "A helpful landing page for families, tutors, teachers, and counselors who support student grade planning."
  }
} satisfies Record<string, ResourceLink>;

export const homepagePopularQuestions: ResourceLink[] = [
  guideResources.howToCalculateYourGrade,
  guideResources.howFinalsAffectYourGrade,
  guideResources.whatGradeDoINeedToPass,
  guideResources.isA70PassingGrade,
  guideResources.whatIsAGoodGpa,
  guideResources.collegesWeightedOrUnweighted
];

export const homepageFeaturedTools: ResourceLink[] = [
  toolResources.gradeCalculator,
  toolResources.finalExamCalculator,
  toolResources.whatGradeDoINeedCalculator,
  toolResources.weightedGradeCalculator,
  toolResources.gpaCalculator
];
